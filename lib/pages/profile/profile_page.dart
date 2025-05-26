import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes.dart';

import 'profile_details_screen.dart';

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => ProfileDetailsRoute().go(context),
          child: const Text('Go to Profile Details'),
        ),
      ),
    );
  }
}
