import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:same_day_delivery_client/model/user.model.dart';

const baseUrl = "http://127.0.0.1:3000";

class ApiService {
  static Future<UserModel> registerUser(UserModel user) async {
    final url = '$baseUrl/user/register';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return UserModel.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to register user. Status code: ${response.statusCode}');
    }
  }

  static Future<UserModel> signInUser(
      String userEmail, String userPassword) async {
    final url = '$baseUrl/user/signin';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userEmail': userEmail,
        'userPassword': userPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return UserModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to sign in. Status code: ${response.statusCode}');
    }
  }
}
