import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';
import 'pages/feed/feed_details_screen.dart';
import 'pages/feed/feed_page.dart';
import 'pages/profile/profile_details_screen.dart';
import 'pages/profile/profile_page.dart';

part 'routes.g.dart';

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
