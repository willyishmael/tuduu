import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuduu/pages/root/root_page.dart';
import 'package:tuduu/pages/task/task_page.dart';
import 'package:tuduu/router/get_page.dart';
import 'package:tuduu/router/paths.dart';

class NavigationHelper {
  static final NavigationHelper _instance = NavigationHelper._internal();
  static NavigationHelper get instance => _instance;

  static late final GoRouter router;

  final GlobalKey<NavigatorState> rootNavigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> taskNavigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'task');
  final GlobalKey<NavigatorState> calendarNavigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'calendar');
  final GlobalKey<NavigatorState> profileNavigationKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile');

  factory NavigationHelper() {
    return _instance;
  }

  NavigationHelper._internal() {
    final routes = <RouteBase>[
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return getPage(
            child: RootPage(child: navigationShell),
            state: state,
          );
        },
        branches: [
          // Task Page
          StatefulShellBranch(
            navigatorKey: taskNavigationKey,
            routes: [
              GoRoute(
                path: Paths.taskPath,
                pageBuilder: (context, state) => getPage(
                  child: const TaskPage(),
                  state: state,
                ),
              )
            ],
          ),

          // Calendar Page
          StatefulShellBranch(
            navigatorKey: calendarNavigationKey,
            routes: [
              GoRoute(
                path: Paths.calendarPath,
                pageBuilder: (context, state) => getPage(
                  child: const Center(child: Text('Calendar Page')),
                  state: state,
                ),
              )
            ],
          ),

          // Profile Page
          StatefulShellBranch(
            navigatorKey: profileNavigationKey,
            routes: [
              GoRoute(
                path: Paths.profilePath,
                pageBuilder: (context, state) => getPage(
                  child: const Center(child: Text('Profile Page')),
                  state: state,
                ),
              )
            ],
          ),
        ],
      )
    ];

    router = GoRouter(
      navigatorKey: rootNavigationKey,
      initialLocation: Paths.taskPath,
      routes: routes,
    );
  }
}
