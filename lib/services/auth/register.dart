import 'package:budget_app_flutter/model/register.dart';
import 'dart:convert';
import 'dart:io';

import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  const RegisterService();

  Future<RegisterResponse> register(String name, String email, String password,
      String confirmPassword) async {
    try {
      final Map<String, String> data = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      };

      final response = await http.post(
        Uri.parse(APIEndpoint.REGISTER_URL),
        headers: APIEndpoint.HEADERS,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final RegisterResponse registerResponse =
            registerModelFromJson(response.body);
        GetStorage().write("registerResponse", registerResponse);
        GetStorage().write("userId", registerResponse.userId);
        return registerResponse;
      } else {
        throw Exception("Failed to register");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      debugPrint("Register service called");
    }
  }
}
