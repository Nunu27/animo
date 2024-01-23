import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBar extends StatelessWidget {
  const ScaffoldWithBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.explore),
            icon: Icon(Icons.explore_outlined),
            label: 'explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'library',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/explore')) {
      return 0;
    }
    if (location.startsWith('/library')) {
      return 1;
    }
    if (location.startsWith('/profile')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/explore');
      case 1:
        GoRouter.of(context).go('/library');
      case 2:
        GoRouter.of(context).go('/profile');
    }
  }

  PreferredSizeWidget? _getAppBar(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case '/explore':
        return AppBar(
          title: const Text('Explore'),
        );
      case '/library':
        return AppBar(
          title: const Text('Library'),
        );
      case '/profile':
        return AppBar(
          title: const Text('Profile'),
        );
    }
    return null;
  }
}
