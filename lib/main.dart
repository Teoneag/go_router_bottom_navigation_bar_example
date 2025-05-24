import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: GoRouter(routes: $appRoutes));
  }
}

@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<HomeRoute>(
          path: '/',
          routes: <TypedGoRoute>[
            //! DO NOT PUT / in the beginning of the path as the path won't be found
            TypedGoRoute<HomeDetailRoute>(path: 'details'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<SettingsRoute>(
          path: '/settings',
          routes: <TypedGoRoute>[
            TypedGoRoute<SettingsDetailsRoute>(path: 'details'),
          ],
        ),
      ],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HomeDetailRoute extends GoRouteData {
  const HomeDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DetailsScreen(title: 'Home Detail');
}

class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class SettingsDetailsRoute extends GoRouteData {
  const SettingsDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DetailsScreen(title: 'settings details');
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                HomeDetailRoute().go(context);
              },
              child: const Text('Go to Home Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String title;
  const DetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Details for $title')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                SettingsDetailsRoute().go(context);
              },
              child: const Text('Go to About'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
