import 'dart:convert';

UserProfileResponse userProfileModelFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  UserProfileModel data;

  UserProfileResponse({
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        data: UserProfileModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserProfileModel {
  int? id;
  String? name;
  String? email;

  UserProfileModel({
    this.id,
    this.name,
    this.email,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
