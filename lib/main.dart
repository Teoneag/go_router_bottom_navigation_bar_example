import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

void main() {
  // TODO
  // ignore: depend_on_referenced_packages
  // import 'package:flutter_web_plugins/url_strategy.dart';
  // usePathUrlStrategy(); // DO NOT use on static servers without proper rewrites
  runApp(MaterialApp.router(routerConfig: goRouter));
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
