import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedDetailRoute extends GoRouteData {
  const FeedDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FeedDetailsScreen();
}

class FeedDetailsScreen extends StatelessWidget {
  const FeedDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed Details')),
      body: Center(child: Text('Feed Details Screen')),
    );
  }
}
