import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:same_day_delivery_client/components/navBar.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  ScaffoldWithBottomNavBar({super.key, required this.navigationShell});
  final labels = ['Home', 'Cart', 'Messages', 'Profile'];
  final icons = [
    Icons.home,
    Icons.shopping_bag,
    Icons.chat,
    Icons.person_outline
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(
                navigationShell: navigationShell, icons: icons, labels: labels),
          )
        ],
      ),
    );
  }
}
