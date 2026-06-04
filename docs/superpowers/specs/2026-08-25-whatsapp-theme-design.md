# WhatsApp light/dark theme — design

Date: 2026-08-25
Status: implemented

## Goal

Replace the seeded Material 3 theme with WhatsApp's own light and dark
palettes and typography, remove every trace of the previous theming, and keep
the runtime cost at zero.

## Research

### Typography

WhatsApp's product typeface is **WhatsApp Sans Var**, a proprietary Meta
variable font. It is not licensed for redistribution and is not obtainable
from Meta's Brand Resource Center. The logo wordmark is Helvetica Neue 75
Bold — a licensed commercial face, and irrelevant to UI text.

Inside the mobile app, WhatsApp does not use either: it renders UI text in the
**platform system font** — Roboto on Android, SF Pro on iOS.

Decision: ship **no font assets** and set no `fontFamily`. This is both the
faithful choice and the cheapest one — no font file in the APK, no font
loading, no first-paint reflow.

Sources: [Meta Brand Resource Center](https://www.meta.com/brand/resources/whatsapp/whatsapp-brand/),
[designyourway](https://www.designyourway.net/blog/whatsapp-font/),
[fontinlogo](https://www.fontinlogo.com/logo/whatsapp).

### Colour

Values were taken only from sources that agree across independent references
and match WhatsApp's shipping surfaces. Teardown-only values (`#1DAA61`,
`#21C063`) were rejected as unverified, as were the legacy teal values
(`#075E54`, `#128C7E`), which WhatsApp dropped in the 2024 redesign.

| Role | Light | Dark |
| --- | --- | --- |
| primary | `#008069` | `#00A884` |
| brand green (fill only) | `#25D366` | `#25D366` |
| surface | `#FFFFFF` | `#111B21` |
| surface container | `#F0F2F5` | `#202C33` |
| surface container high | `#F0F2F5` | `#2A3942` |
| chat canvas | `#EFEAE2` | `#0B141A` |
| outgoing bubble | `#D9FDD3` | `#005C4B` |
| on surface | `#111B21` | `#E9EDEF` |
| on surface variant | `#667781` | `#8696A0` |
| outline | `#D1D7DB` | `#2A3942` |
| outline variant | `#E9EDEF` | `#222D34` |
| error | `#DF3333` | `#F15C6D` |

`#25D366` is the only value Meta publishes. At 1.9:1 on white it is a fill
colour only and is never used for text or icons on a light surface; a test
locks that constraint in.

Sources: [themeandcolor](https://themeandcolor.com/blog/whatsapp-dark-mode-colors),
[inspiretips](https://inspiretips.blog/whatsapp-dark-mode-palette-official-hex-codes-38439),
[usbrandcolors](https://usbrandcolors.com/whatsapp-colors/),
[Business Standard](https://www.business-standard.com/technology/apps/whatsapp-gets-a-design-makeover-with-new-colour-palette-icons-and-more-124051000258_1.html),
[GSMArena](https://m.gsmarena.com/whatsapp_gets_a_new_fresher_look_and_a_darker_dark_mode-news-62801.php).

The official [WhatsApp/stickers](https://github.com/WhatsApp/stickers) sample
app was checked and rejected: its `colors.xml` still ships `#128C7E`.

## Architecture

```
lib/core/theme/
  wa_colors.dart     const Color tokens — the single source of truth
  wa_palette.dart    const WaPalette light/dark + O(1) of(context)
  app_theme.dart     hand-written ColorSchemes + static final ThemeData
  wa_system_ui.dart  two const SystemUiOverlayStyle
```

Four decisions carry the performance claim:

1. **No `ColorScheme.fromSeed`.** Seeding runs HCT tonal-palette maths at
   startup and yields ~60 derived colours, none of them WhatsApp's. Both
   schemes are `const ColorScheme(...)`, so they are const-folded.
2. **`static final ThemeData`, not `static ThemeData get`.** The previous
   getter allocated a fresh `ThemeData` — and every sub-theme under it — on
   each read by `MaterialApp`.
3. **`WaPalette` is not a `ThemeExtension`.** An extension requires a `lerp`
   implementation that allocates a new palette on every frame of a theme
   transition. Two const objects plus a brightness read cost nothing.
4. **Const `SystemUiOverlayStyle`.** The previous root builder called
   `ThemeData.estimateBrightnessForColor` — relative-luminance maths — on
   every rebuild of the app root.

`WaPalette` holds only what `ColorScheme` has no slot for: `brandGreen`,
`chatCanvas`, `badge`. Anything expressible as a scheme role (dividers, muted
text) stays in the scheme rather than being duplicated.

## Components

- `WaBottomNav` — WhatsApp's bottom bar: top hairline, stadium pill behind the
  selected icon (`primaryContainer`), label always visible. Hand-rolled rather
  than `NavigationBar`, whose indicator and per-destination label opacity
  animate on every selection change; WhatsApp's swaps instantly.
- `BaseScreen` — `WaBottomNav` plus an end-floating squircle FAB, replacing the
  docked-FAB `BottomAppBar` with its notch.
- `LibraryScreen` — chat-list row styling (square thumbnail, title, muted
  subtitle, no card, no divider), a real empty state, and `ListView.builder`
  in place of an eagerly built `ListView`.
- `LocalPackPreview` — thumbnails sit on the chat-wallpaper tone so transparent
  WebP stickers read as they do in a chat; adds `cacheWidth` decoding at
  display size.
- `ImageEditor` — `pro_image_editor` receives `AppTheme.dark`; WhatsApp keeps
  its media editor dark in both app themes.

## Android native

Six `styles.xml` variants (`values`, `-v29`, `-v31` and their `-night`
counterparts) now use `#FFFFFF` / `#111B21` for the window, navigation bar and
Android 12+ splash. `NormalTheme`'s `windowBackground` moved from
`?android:colorBackground` to an explicit hex so no OEM grey flashes before
first frame. The splash `background.png` files were regenerated at the same two
colours, and `flutter_native_splash.yaml` was updated so regeneration
reproduces them.

## Removed

- `ColorScheme.fromSeed` theming.
- `bottom_navigation_widget.dart` (an unused `Placeholder`).
- Legacy teal `#075E54` / `#128C7E` from the splash config and Android 12+
  splash styles.
- Material-derived navigation bar colours `#EBEFE7` / `#1C211C`.

## Verification

`test/core/theme/app_theme_test.dart` asserts the scheme values, single
`ThemeData` construction, absence of bundled fonts, `WaPalette` resolution by
brightness, and WCAG contrast: 4.5:1 for body/on-primary/inverse/container
pairs in both modes, 3:1 for muted text and error, and — deliberately — under
4.5:1 for brand green on white, so it stays fill-only.

`flutter analyze` is clean apart from one pre-existing warning in
`store_remote_source.dart`, unrelated to theming.
