import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/model/user.model.dart';

class ApiService {
  static final CookieJar cookieJar = CookieJar();
  static const String _baseUrl = "http://192.168.12.73:3000/";
  get baseUrl => _baseUrl;
  static final Dio dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
  ))
    ..interceptors.add(CookieManager(cookieJar));

  static Future signInUser(String username, String password) async {
    try {
      final response = await dio.post(
        "/user/login",
        data: {
          "email": username,
          "password": password,
        },
      );
      List<Cookie> cookies =
          await cookieJar.loadForRequest(Uri.parse(_baseUrl));
      print("Cookies: $cookies");

      return response.data;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future registerUser(UserModel user) async {
    try {
      final response = await dio.post(
        "/register",
        data: user,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future getAuthTokenFromCookies() async {
    try {
      List<Cookie> cookies =
          await cookieJar.loadForRequest(Uri.parse(_baseUrl));
      if (cookies.isNotEmpty) {
        for (var cookie in cookies) {
          if (cookie.name == "token") {
            return cookie.value;
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get("/product",
          options: Options(
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            },
            responseType: ResponseType.plain,
          ));
      final responseData = jsonDecode(response.data);
      List<ProductModel> products = [];
      for (var product in responseData["data"]) {
        products.add(ProductModel.fromJson(product));
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
