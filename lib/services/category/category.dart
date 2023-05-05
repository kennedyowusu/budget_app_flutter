import 'dart:io';

import 'package:budget_app_flutter/model/group.dart';
import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final Uri uri = Uri.parse(APIEndpoint.CATEGORY_URL);
  Future<GroupModelResponse> fetchCategories() async {
    final token = GetStorage().read('loginResponse');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    debugPrint("categories: $response");
    debugPrint("Token: $token");

    try {
      if (response.statusCode == 200) {
        final GroupModelResponse groupModelResponse =
            groupModelFromJson(response.body);

        GetStorage().write("categories", groupModelResponse.data);
        return groupModelResponse;
      } else {
        throw Exception("Failed to Fetch Categories");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      debugPrint("$e");
      throw Exception(e.toString());
    } finally {
      print("fetching group failed");
    }
  }
}
