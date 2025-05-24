// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router_builder/go_router_builder.dart';

part 'main.g.dart'; // This line is crucial for code generation

// lib/main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create a global key for the root navigator.
  // This is optional but good practice for scenarios like
  // showing dialogs over the entire app.
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        // Use the generated routes
        routes: $appRoutes,
        // The initial location when the app starts
        initialLocation: '/home',
        // Optional: Add a root navigator key
        navigatorKey: _rootNavigatorKey,
        debugLogDiagnostics: true, // Good for debugging navigation
      ),
      title: 'GoRouter Type-Safe Bottom Nav Example',
    );
  }
}

// --- Main Shell Route for Bottom Navigation Bar ---
@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch<HomeBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<HomeRoute>(
          path: '/home',
          routes: <TypedGoRoute>[
            TypedGoRoute<HomeDetailRoute>(path: 'details/:id'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<SettingsRoute>(
          path: '/settings',
          routes: <TypedGoRoute>[
            TypedGoRoute<SettingsAboutRoute>(path: 'about'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<ProfileRoute>(
          path: '/profile',
          routes: <TypedGoRoute>[TypedGoRoute<ProfileEditRoute>(path: 'edit')],
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

// --- Home Tab Routes ---
class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HomeDetailRoute extends GoRouteData {
  const HomeDetailRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HomeDetailScreen(id: id);
}

// --- Settings Tab Routes ---
class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class SettingsAboutRoute extends GoRouteData {
  const SettingsAboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsAboutScreen();
}

// --- Profile Tab Routes ---
class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class ProfileEditRoute extends GoRouteData {
  const ProfileEditRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileEditScreen();
}

// --- Screens (Simplified for example) ---
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
            const Text('Welcome to Home!'),
            ElevatedButton(
              onPressed: () {
                HomeDetailRoute(id: '123').go(context);
              },
              child: const Text('Go to Home Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Detail')),
      body: Center(child: Text('This is Home Detail screen with ID: $id')),
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
            const Text('Settings Page'),
            ElevatedButton(
              onPressed: () {
                SettingsAboutRoute().go(context);
              },
              child: const Text('Go to About'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsAboutScreen extends StatelessWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(child: Text('This is the About screen.')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Page'),
            ElevatedButton(
              onPressed: () {
                ProfileEditRoute().go(context);
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: const Center(child: Text('This is the Edit Profile screen.')),
    );
  }
}

// --- Scaffold with Bottom Navigation Bar ---
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey('ScaffoldWithNavBar'));

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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) {
          // Use `goBranch` to navigate to the selected branch,
          // preserving the navigation stack of the target branch.
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
