import 'dart:convert';

GroupModelResponse groupModelFromJson(String str) =>
    GroupModelResponse.fromJson(json.decode(str));

String groupModelToJson(GroupModelResponse data) => json.encode(data.toJson());

class GroupModelResponse {
  List<GroupModel> data;

  GroupModelResponse({
    required this.data,
  });

  factory GroupModelResponse.fromJson(Map<String, dynamic> json) =>
      GroupModelResponse(
        data: List<GroupModel>.from(
            json["data"].map((x) => GroupModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GroupModel {
  int? id;
  String name;
  String icon;
  String? description;
  int? isActive;
  int userId;

  GroupModel({
    this.id,
    required this.name,
    required this.icon,
    this.description,
    this.isActive,
    required this.userId,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        description: json["description"],
        isActive: json["is_active"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "description": description,
        "is_active": isActive,
        "user_id": userId,
      };
}
