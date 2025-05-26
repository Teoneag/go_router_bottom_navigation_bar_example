import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'main.g.dart';

void main() {
  // TODO
  // ignore: depend_on_referenced_packages
  // import 'package:flutter_web_plugins/url_strategy.dart';
  // usePathUrlStrategy(); // DO NOT use on static servers without proper rewrites
  runApp(MaterialApp.router(routerConfig: goRouter));
}

// Must be a final var outside widgets to avoid navigating home on hot reload
final goRouter = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: true, // To see all the routes
);

@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch>[
    TypedStatefulShellBranch<FeedBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<FeedRoute>(
          path: '/',
          routes: <TypedGoRoute>[
            //! DO NOT PUT / in the beginning of the path as the path won't be found
            TypedGoRoute<FeedDetailRoute>(path: 'details'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: <TypedGoRoute>[
        TypedGoRoute<ProfileRoute>(
          path: '/profile',
          routes: <TypedGoRoute>[
            TypedGoRoute<ProfileDetailsRoute>(path: 'details'),
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

class FeedBranch extends StatefulShellBranchData {
  const FeedBranch();
}

class FeedRoute extends GoRouteData {
  const FeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FeedScreen();
}

class FeedDetailRoute extends GoRouteData {
  const FeedDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DetailsScreen(title: 'Feed Detail');
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class ProfileDetailsRoute extends GoRouteData {
  const ProfileDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DetailsScreen(title: 'Profile Details');
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FeedDetailRoute().go(context);
              },
              child: const Text('Go to Feed Details'),
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
            ElevatedButton(
              onPressed: () {
                ProfileDetailsRoute().go(context);
              },
              child: const Text('Go to Profile Details'),
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
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
