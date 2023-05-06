import 'dart:convert';
import 'dart:io';

import 'package:budget_app_flutter/model/group.dart';
import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
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

        debugPrint("categories: $groupModelResponse");

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
      debugPrint("fetching group failed");
    }
  }

  Future<GroupModelResponse> createCategory(
      String categoryName, String categoryIconLink, int userId) async {
    try {
      final Map<String, dynamic> categoryData = {
        'name': categoryName,
        'icon': categoryIconLink,
        'user_id': userId,
      };

      final token = GetStorage().read('loginResponse');

      // Fetch the list of existing categories from the server
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final GroupModelResponse groupModelResponse =
            groupModelFromJson(response.body);

        // Check if the category name already exists
        if (groupModelResponse.data.any((category) =>
            category.name.toLowerCase() == categoryName.toLowerCase())) {
          ToastWidget.showToast(
            "Category already exists",
          );
          throw Exception("Category already exists");
        }

        // If the category name does not exist, create the category
        final postResponse = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(categoryData),
        );

        if (postResponse.statusCode == 201 && postResponse.body.isNotEmpty) {
          final GroupModelResponse newGroupModelResponse =
              groupModelFromJson(postResponse.body);

          GetStorage().write("category", newGroupModelResponse.data);
          return newGroupModelResponse;
        } else {
          throw Exception(
              "Failed to create Category ${postResponse.statusCode}");
        }
      } else {
        throw Exception("Failed to fetch categories ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      debugPrint('Failed to create a User\'s Category');
    }
  }
}
