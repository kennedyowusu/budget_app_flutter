import 'dart:convert';
import 'dart:io';

import 'package:budget_app_flutter/constants/endpoints.dart';
import 'package:budget_app_flutter/model/transaction.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  final Uri uri = Uri.parse(APIEndpoint.TRANSACTION_URL);

  Future<TransactionModelResponse> getTransactions() async {
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
        final TransactionModelResponse transactionModelResponse =
            transactionModelFromJson(response.body);

        debugPrint("categories: $transactionModelResponse");

        GetStorage().write("transactions", transactionModelResponse.data);
        return transactionModelResponse;
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

  Future<TransactionModelResponse> createTransaction(
      String transactionName, String transactionIconAmount, int userId) async {
    try {
      final Map<String, dynamic> transactionData = {
        'name': transactionName,
        'amount': transactionIconAmount,
        'user_id': userId,
      };

      final token = GetStorage().read('loginResponse');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final TransactionModelResponse transactionModelResponse =
            transactionModelFromJson(response.body);

        debugPrint("categories: $transactionModelResponse");

        if (transactionModelResponse.data.any((transaction) =>
            transaction.name.toLowerCase() == transactionName.toLowerCase())) {
          ToastWidget.showToast(
            "Transaction Already exist",
          );
          throw Exception("Transaction already exist");
        }

        final transactionResponse = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/jon',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(transactionData),
        );

        if (transactionResponse.statusCode == 201 &&
            transactionResponse.body.isNotEmpty) {
          final TransactionModelResponse transactionModelResponse =
              transactionModelFromJson(transactionResponse.body);

          GetStorage().write("transactions", transactionModelResponse.data);
          return transactionModelResponse;
        } else {
          throw Exception(
            "Failed to create Transaction ${transactionResponse.statusCode}",
          );
        }
      } else {
        throw Exception("Failed to Fetch Transactions");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      debugPrint("Failed to create User's transaction");
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    final token = GetStorage().read('loginResponse');
    final response = await http.get(
      Uri.parse("${APIEndpoint.CATEGORY_URL}/$transactionId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    try {
      if (response.statusCode == HttpStatus.ok) {
        final transaction =
            TransactionModel.fromJson(jsonDecode(response.body));
        if (transaction.userId != GetStorage().read('userId')) {
          const message = "Unauthorized";
          ToastWidget.showToast(message);
          throw Exception(message);
        }
        final deleteResponse = await http.delete(
          Uri.parse("${APIEndpoint.CATEGORY_URL}/$transactionId"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (deleteResponse.statusCode == HttpStatus.ok) {
          // ToastWidget.showToast("Transaction deleted");
          return;
        } else if (deleteResponse.statusCode == HttpStatus.notFound) {
          const message = "Transaction not found";
          // ToastWidget.showToast(message);
          throw Exception(message);
        } else {
          const message = "Failed to delete Transaction";
          // ToastWidget.showToast(message);
          throw Exception(message);
        }
      } else if (response.statusCode == HttpStatus.notFound) {
        const message = "Transaction not found";
        ToastWidget.showToast(message);
        throw Exception(message);
      } else {
        const message = "Failed to get Transaction";
        ToastWidget.showToast(message);
        throw Exception(message);
      }
    } catch (e) {
      debugPrint("$e");
      throw Exception(e.toString());
    } finally {
      debugPrint("deleting Transaction failed");
    }
  }
}
