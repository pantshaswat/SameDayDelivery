import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:same_day_delivery_client/model/user.model.dart';

const baseUrl = "http://127.0.0.1:3000";

class ApiService {
  static Future<UserModel> registerUser() async {
    const url = '$baseUrl/user/register';
    UserModel user = UserModel(
      userId: "123",
      userName: "John Doe",
      userEmail: "example@gmail.com",
      userPassword: "password",
      userPhone: "9842038323",
      userAddress: "Kathmandu",
      userDate: "2022-01-01",
    );
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
      throw Exception('Failed to register user code: ${response.statusCode}');
    }
  }
}
