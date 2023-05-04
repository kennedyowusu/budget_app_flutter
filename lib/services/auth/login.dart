import 'dart:convert';
import 'dart:io';

import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:budget_app_flutter/model/login.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  const LoginService();

  Future<LoginResponse> login(String email, String password) async {
    try {
      final Map<String, String> data = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(APIEndpoint.LOGIN_URL),
        headers: APIEndpoint.HEADERS,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final LoginResponse loginResponse = loginModelFromJson(response.body);
        GetStorage().write("loginResponse", loginResponse.accessToken);
        return loginResponse;
      } else {
        throw Exception("Failed to login");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      print("Login service called");
    }
  }
}

Future<void> logout() async {
  GetStorage().remove("loginResponse");
}
