import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes.dart';
import 'feed_details_screen.dart';

class FeedBranch extends StatefulShellBranchData {
  const FeedBranch();
}

class FeedRoute extends GoRouteData {
  const FeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FeedPage();
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => FeedDetailRoute().go(context),
          child: const Text('Go to Feed Details'),
        ),
      ),
    );
  }
}
