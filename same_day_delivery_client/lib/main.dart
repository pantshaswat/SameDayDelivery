import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/features/auth/views/login_screen.dart';
import 'package:same_day_delivery_client/features/auth/views/register_screen.dart';
import 'package:same_day_delivery_client/features/cart/views/cart_page.dart';
import 'package:same_day_delivery_client/features/cart/views/checkout_page.dart';
import 'package:same_day_delivery_client/features/home/views/home_page.dart';
import 'package:same_day_delivery_client/features/home/views/product_page.dart';
import 'package:same_day_delivery_client/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Same Day Delivery",
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
