import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:same_day_delivery_client/model/product.model.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:same_day_delivery_client/services/extractToken.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class ApiService {
  static final CookieJar cookieJar = CookieJar();
  static const String _baseUrl = "http://10.0.2.2:3000/";
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
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          responseType: ResponseType.plain,
        ),
      );
      List<Cookie> cookies =
          await cookieJar.loadForRequest(Uri.parse(_baseUrl));
      print(cookies.toString());
      final token = extractAndProcessToken(cookies.toString());
      if (token != null) {
        await LocalStorage.saveToken(token);
      }
      final responseData = jsonDecode(response.data);
      print(responseData);

      final userType = responseData["user"]["role"] ?? "user";
      print(userType);
      // await LocalStorage.saveUserType(userType);
      // await LocalStorage.saveUser(UserModel.fromJson(responseData["user"]));
      return responseData;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future registerUser(UserModel user) async {
    try {
      final response = await dio.post(
        "/user/register",
        data: user,
      );
      return response;
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
      final Response response = await dio.get("/product",
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
