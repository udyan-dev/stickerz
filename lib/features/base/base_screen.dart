import 'package:flutter/material.dart';

import '../../core/di/service_locator.dart';
import '../../core/theme/wa_icons.dart';
import '../../core/util/constants/constants.dart';
import '../library/presentation/library_cubit.dart';
import '../library/presentation/screens/library_pack_screen.dart';
import '../library/presentation/screens/library_screen.dart';
import 'widgets/wa_bottom_nav.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  static const List<WaNavDestination> _destinations = <WaNavDestination>[
    WaNavDestination(
      icon: WaIcons.stickers,
      selectedIcon: WaIcons.stickersFilled,
      label: AppUiStrings.homeTab,
    ),
    WaNavDestination(
      icon: WaIcons.store,
      selectedIcon: WaIcons.storeFilled,
      label: AppUiStrings.storeTab,
    ),
  ];

  late final LibraryCubit _libraryCubit;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _libraryCubit = serviceLocator<LibraryCubit>()..loadLocalPacks();
  }

  @override
  void dispose() {
    _libraryCubit.close();
    super.dispose();
  }

  Future<void> _openCreatePack() {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LibraryPackScreen(cubit: _libraryCubit),
      ),
    );
  }

  Future<void> _openPack(String packId) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LibraryPackScreen(cubit: _libraryCubit, packId: packId),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          LibraryScreen(
            cubit: _libraryCubit,
            onCreatePack: _openCreatePack,
            onOpenPack: _openPack,
          ),
          const _StorePlaceholderScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreatePack,
        tooltip: LibraryUiStrings.addPackTooltip,
        child: const Icon(WaIcons.add),
      ),
      bottomNavigationBar: WaBottomNav(
        destinations: _destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

class _StorePlaceholderScreen extends StatelessWidget {
  const _StorePlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppUiStrings.storeTab)),
      body: const Center(child: Text(BaseUiStrings.storePlaceholder)),
    );
  }
}
