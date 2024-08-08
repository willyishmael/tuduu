import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  final StatefulNavigationShell child;

  const RootPage({
    super.key,
    required this.child,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final destinations = const [
    NavigationDestination(icon: Icon(Icons.task), label: 'Task'),
    NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Calendar'),
    NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        bottomNavigation: SlotLayout(config: {
          Breakpoints.smallMobile: SlotLayout.from(
            key: const Key('bottom-navigation-bar-small'),
            builder: (_) => rootBottomNavigationBar(),
          )
        }),
        primaryNavigation: SlotLayout(config: {
          Breakpoints.mediumMobile: SlotLayout.from(
            key: const Key('primary-navigation-rail-small'),
            builder: (_) => rootNavigationRailSmall(),
          ),
          Breakpoints.largeMobile: SlotLayout.from(
            key: const Key('primary-navigation-rail-large'),
            builder: (_) => rootNavigationRailLarge(),
          ),
        }),
        body: SlotLayout(config: {
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('primary-body-small'),
            builder: (_) => SafeArea(child: widget.child),
          )
        }),
      ),
    );
  }

  Builder rootBottomNavigationBar() {
    return AdaptiveScaffold.standardBottomNavigationBar(
      onDestinationSelected: (int index) {
        widget.child.goBranch(
          index,
          initialLocation: index == widget.child.currentIndex,
        );
      },
      currentIndex: widget.child.currentIndex,
      destinations: destinations,
    );
  }

  Builder rootNavigationRailSmall() {
    return AdaptiveScaffold.standardNavigationRail(
      onDestinationSelected: (int index) {
        widget.child.goBranch(
          index,
          initialLocation: index == widget.child.currentIndex,
        );
      },
      selectedIndex: widget.child.currentIndex,
      destinations: destinations
          .map((d) => AdaptiveScaffold.toRailDestination(d))
          .toList(),
    );
  }

  Builder rootNavigationRailLarge() {
    return AdaptiveScaffold.standardNavigationRail(
      onDestinationSelected: (int index) {
        widget.child.goBranch(
          index,
          initialLocation: index == widget.child.currentIndex,
        );
      },
      selectedIndex: widget.child.currentIndex,
      extended: true,
      destinations: destinations
          .map((d) => AdaptiveScaffold.toRailDestination(d))
          .toList(),
    );
  }
}
