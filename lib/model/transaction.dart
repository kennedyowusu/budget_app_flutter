// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModelResponse transactionModelFromJson(String str) =>
    TransactionModelResponse.fromJson(json.decode(str));

String transactionModelToJson(TransactionModelResponse data) =>
    json.encode(data.toJson());

class TransactionModelResponse {
  List<TransactionModel> data;

  TransactionModelResponse({
    required this.data,
  });

  factory TransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      TransactionModelResponse(
        data: List<TransactionModel>.from(
            json["data"].map((x) => TransactionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TransactionModel {
  int id;
  String name;
  String amount;
  int userId;
  int groupId;
  DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.userId,
    required this.groupId,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        userId: json["user_id"],
        groupId: json["group_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "user_id": userId,
        "group_id": groupId,
        "created_at": createdAt.toIso8601String(),
      };
}
