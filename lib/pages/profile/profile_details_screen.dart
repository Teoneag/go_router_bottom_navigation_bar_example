import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailsRoute extends GoRouteData {
  const ProfileDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileDetailsScreen();
}

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Details')),
      body: Center(child: Text('Profile Details Screen')),
    );
  }
}
