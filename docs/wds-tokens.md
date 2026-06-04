# WhatsApp design tokens (WDS)

Source of truth: the `--WDS-*` custom properties in the stylesheet served by
`web.whatsapp.com` (`static.whatsapp.net/rsrc.php/.../*.css`). That is the token
layer behind the 2024/2025 redesign — warm light neutrals, one green ramp, a
one-shade-darker dark mode. Colour-aggregator sites still publish the 2014 logo
palette (`#075E54`, `#128C7E`, `#DCF8C6`); those values are dead.

Semantic light/dark pairs: `wds-tokens.tsv` (dumped from the shipped CSS).

## Green ramp (`--WDS-green-*`)

| step | hex | role |
|---|---|---|
| 75 | `#E7FCE3` | positive surface |
| 100 | `#D9FDD3` | `accent-deemphasized`, outgoing bubble (light) |
| 200 | `#ACFCAC` | |
| 300 | `#71EB85` | `secondary-positive` (dark) |
| 400 | `#25D366` | brand/logo green, activity indicator — fill only (2:1 on white) |
| 450 | `#21C063` | `accent` (dark) |
| 500 | `#1DAA61` | `accent` (light) |
| 600 | `#1B8755` | `content-action-emphasized` (light) |
| 700 | `#15603E` | `accent-emphasized` (light) — accent *text* |
| 750 | `#144D37` | outgoing bubble (dark) |
| 800 | `#103529` | `accent-deemphasized` (dark) |

## Surfaces

| | light | dark |
|---|---|---|
| `surface-default` | `#FFFFFF` | `#161717` |
| `surface-emphasized` | `#F7F5F3` | `#1D1F1F` |
| `surface-elevated-emphasized` | `#F7F5F3` | `#242626` |
| `components-surface-nav-bar` | `#F7F5F3` | `#1D1F1F` |
| `chat-background-wallpaper` | `#F5F1EB` | `#161717` |
| `content-default` | `#0A0A0A` | `#FAFAFA` |
| `content-deemphasized` | `rgba(0,0,0,.6)` | `rgba(255,255,255,.6)` |
| `lines-outline-default` | `#959393` | `#757778` |

Light mode runs on the **warm** gray ramp (`#F7F5F3`…`#171616`); dark mode on the
**neutral** ramp (`#FAFAFA`…`#0A0A0A`). The old cool blue-grays (`#111B21`,
`#202C33`, `#F0F2F5`) survive only in legacy WhatsApp Web chat CSS.

## Type

The WDS type tokens name **Optimistic** (`Optimistic VF App Lite`), Meta's
proprietary variable family. It is not licensable and WhatsApp does not serve
it: web.whatsapp.com ships two `@font-face` rules, both `Roboto Variable`
(`wght 100..900`, upright + italic). So Roboto *is* the shipping face, and the
app bundles it — `assets/fonts/Roboto-wght.ttf`, 119KB, `wdth` pinned to 100,
`wght` axis live, Latin + Latin Ext + symbols, SIL OFL 1.1.

| size/line-height | weights | role |
|---|---|---|
| 48/52 | 600 | display |
| 28/32 | 600 | large header |
| 24/28 | 600 | inbox header |
| 15/19 | 700, 500 | row title, body/message |
| 13/17 | 700, 400 | section header, subtitle |
| 11/16 | 500, 400 | nav label, timestamp |

Tracking is `0` at every step. A variable face does not respond to
`fontWeight` alone, so every step also carries a `FontVariation('wght', n)`.

## Icons

WhatsApp's post-2024 glyphs are rounded, outlined, in-house artwork served from
authenticated app chunks — not published, and not ours to redistribute. The app
ships Google's Material Symbols **Rounded** instead (same 24dp grid, rounded
terminals, 400 stroke, `opsz=24`, `GRAD=0`), as **compiled vector assets, not a
font**: each official SVG is compiled to a `.vec` by `vector_graphics_compiler`.
27 files in `assets/icons`, 24KB total, Apache 2.0.

`.vec` is `vector_graphics`' precompiled format — paths are parsed and
optimised at build time, so the device only decodes and paints. No icon font is
bundled and no SVG is parsed at runtime.

Selected state loads that icon's `FILL 1` asset; only the bottom-nav
destinations have one. Draw an icon with `WaIcon`, which resolves colour and
size from the ambient `IconTheme` exactly as `Icon` does:

```dart
WaIcon(WaIcons.stickers, filled: isSelected)
```

## Rebuilding the assets

```sh
python3 tool/build_icons.py                       # SVGs -> .vec

python3 -m venv .venv && .venv/bin/pip install fonttools brotli
.venv/bin/python tool/build_fonts.py              # Roboto subset
```

Both scripts fetch upstream, write into `assets/`, and copy the licence next to
what they produce. `test/core/theme/icon_assets_test.dart` then decodes every
declared `.vec` and fails on a missing or orphaned asset;
`test/core/theme/font_assets_test.dart` verifies the font's `wght` axis moves
and its subset covers the ranges a pack name can contain.
