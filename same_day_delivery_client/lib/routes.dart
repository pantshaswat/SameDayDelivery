import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:same_day_delivery_client/components/scaffold_with_navBar.dart';
import 'package:same_day_delivery_client/features/auth/views/login_screen.dart';
import 'package:same_day_delivery_client/features/cart/views/cart_page.dart';
import 'package:same_day_delivery_client/features/cart/views/checkout_page.dart';
import 'package:same_day_delivery_client/features/home/views/home_page.dart';
import 'package:same_day_delivery_client/features/profile/views/profile_page.dart';

GoRouter goRouter = GoRouter(routes: [
  GoRoute(
      name: "signuplogin",
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ScaffoldWithBottomNavBar(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                  name: "home",
                  path: "home",
                  builder: (BuildContext context, GoRouterState state) {
                    return HomePage();
                  },
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    name: "cart",
                    path: "cart",
                    builder: (BuildContext context, GoRouterState state) {
                      return CartPage();
                    },
                    routes: <RouteBase>[
                      GoRoute(
                          path: 'checkout',
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  CheckoutPage())
                    ])
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    name: "chat",
                    path: "Chat",
                    builder: (BuildContext context, GoRouterState state) {
                      return Center(
                          child: Container(
                        child: Text("Chat"),
                      ));
                    }),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    name: "profile",
                    path: "profile",
                    builder: (BuildContext context, GoRouterState state) {
                      return ProfilePage();
                    }),
              ]),
            ])
      ])
]);
