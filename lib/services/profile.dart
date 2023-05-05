import 'package:budget_app_flutter/model/profile.dart';
import 'dart:io';

import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserProfileService {
  final Uri uri = Uri.parse(APIEndpoint.USER_PROFILE_URL);

  Future<UserProfileResponse> getUserProfile() async {
    final token = GetStorage().read('loginResponse');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    debugPrint("user profile response: $response");
    debugPrint("Token: $token");

    try {
      if (response.statusCode == 200) {
        final UserProfileResponse userProfileResponse =
            userProfileModelFromJson(response.body);

        GetStorage().write('profile', userProfileResponse.data);
        return userProfileResponse;
      } else {
        throw Exception("Error Fetching User Profile");
      }
    } on SocketException {
      throw Exception("No Internet connection");
    } catch (e) {
      debugPrint("$e");
      throw Exception(e.toString());
    } finally {
      print("fetching group failed");
    }
  }
}
