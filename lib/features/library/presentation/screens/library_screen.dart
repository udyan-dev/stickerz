import 'package:flutter/material.dart';

import '../../../../core/error/app_error.dart';
import '../../../../core/theme/wa_icons.dart';
import '../../../../core/util/constants/constants.dart';
import '../../domain/pack_models.dart';
import '../library_cubit.dart';
import '../library_state.dart';
import '../widgets/local_pack_preview.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({
    required this.cubit,
    required this.onCreatePack,
    required this.onOpenPack,
    super.key,
  });

  final LibraryCubit cubit;
  final Future<void> Function() onCreatePack;
  final Future<void> Function(String packId) onOpenPack;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LibraryState>(
      stream: cubit.stream,
      initialData: cubit.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? cubit.state;
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppUiStrings.appTitle),
            actions: <Widget>[
              IconButton(
                onPressed: onCreatePack,
                icon: const Icon(WaIcons.add),
                tooltip: LibraryUiStrings.addPackTooltip,
              ),
            ],
          ),
          body: switch ((state.loading, state.packs.isEmpty)) {
            (true, true) => const Center(child: CircularProgressIndicator()),
            (_, true) => _LibraryEmptyState(
              error: state.error?.userMessage,
              onCreatePack: onCreatePack,
            ),
            _ => _LibraryPackList(
              packs: state.packs,
              invalidPacks: state.invalidPacks,
              error: state.error?.userMessage,
              onOpenPack: onOpenPack,
            ),
          },
        );
      },
    );
  }
}

class _LibraryEmptyState extends StatelessWidget {
  const _LibraryEmptyState({required this.error, required this.onCreatePack});

  final String? error;
  final Future<void> Function() onCreatePack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(WaIcons.stickers, size: 72, color: scheme.onSurfaceVariant),
            const SizedBox(height: 20),
            Text(
              LibraryUiStrings.emptyLibraryTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              LibraryUiStrings.emptyLibraryMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (error != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreatePack,
              icon: const Icon(WaIcons.add, size: WaIconSize.small),
              label: const Text(LibraryUiStrings.createFirstPackAction),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryPackList extends StatelessWidget {
  const _LibraryPackList({
    required this.packs,
    required this.invalidPacks,
    required this.error,
    required this.onOpenPack,
  });

  final List<StickerPack> packs;
  final Map<String, AppError> invalidPacks;
  final String? error;
  final Future<void> Function(String packId) onOpenPack;

  @override
  Widget build(BuildContext context) {
    final hasBanner = error != null;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: packs.length + (hasBanner ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasBanner && index == 0) {
          return _LibraryErrorBanner(message: error!);
        }
        final pack = packs[index - (hasBanner ? 1 : 0)];
        return _LibraryPackRow(
          pack: pack,
          error: invalidPacks[pack.id],
          onTap: () => onOpenPack(pack.id),
        );
      },
    );
  }
}

class _LibraryErrorBanner extends StatelessWidget {
  const _LibraryErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(WaIcons.info, size: WaIconSize.small, color: scheme.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A WhatsApp chat-list row: square thumbnail, title, muted subtitle, no card
/// and no divider.
class _LibraryPackRow extends StatelessWidget {
  const _LibraryPackRow({
    required this.pack,
    required this.error,
    required this.onTap,
  });

  final StickerPack pack;
  final AppError? error;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isInvalid = error != null;

    return ListTile(
      onTap: onTap,
      shape: const RoundedRectangleBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: LocalPackPreview(
        path: pack.trayPath,
        fallbackIcon: pack.tray.isEmpty ? WaIcons.resize : WaIcons.gallery,
      ),
      title: Text(
        pack.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        error?.userMessage ??
            LibraryUiStrings.packSummary(pack.stickers.length, pack.version),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isInvalid ? scheme.error : scheme.onSurfaceVariant,
        ),
      ),
      trailing: isInvalid
          ? Icon(WaIcons.warning, color: scheme.error)
          : Icon(WaIcons.forward, color: scheme.onSurfaceVariant),
    );
  }
}
