// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) =>
    UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) =>
    json.encode(data.toJson());

class UpdateProfileResponseModel {
  bool? success;
  Data? data;
  String? message;

  UpdateProfileResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  String? userId;
  String? id;
  String? name;
  String? email;
  String? dob;
  String? mobile;

  Data({
    this.userId,
    this.id,
    this.name,
    this.email,
    this.dob,
    this.mobile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "name": name,
        "email": email,
        "dob": dob,
        "mobile": mobile,
      };
}
