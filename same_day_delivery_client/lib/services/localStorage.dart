import 'dart:convert';

import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<void> saveCartitems(
      {required List<ProductModel> cartItems}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final existingItems = prefs.getStringList('cartItems') ?? [];
    final List<String> cartItemsString = [];
    for (var item in cartItems) {
      cartItemsString.add(item.toJsonString());
    }
    existingItems.addAll(cartItemsString);
    prefs.setStringList('cartItems', existingItems);
    return;
  }

  static Future<List<ProductModel>?> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartItems = prefs.getStringList('cartItems');
    if (cartItems == null) {
      return null;
    }
    final List<ProductModel> cartItemsList = [];
    for (var item in cartItems) {
      cartItemsList.add(ProductModel.fromJsonString(item));
    }
    return cartItemsList;
  }

  static Future<void> removeCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartItems');
  }
}
