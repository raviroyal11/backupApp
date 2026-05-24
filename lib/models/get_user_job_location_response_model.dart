// To parse this JSON data, do
//
//     final getUserJobLocationResponseModel = getUserJobLocationResponseModelFromJson(jsonString);

import 'dart:convert';

GetUserJobLocationResponseModel getUserJobLocationResponseModelFromJson(
        String str) =>
    GetUserJobLocationResponseModel.fromJson(json.decode(str));

String getUserJobLocationResponseModelToJson(
        GetUserJobLocationResponseModel data) =>
    json.encode(data.toJson());

class GetUserJobLocationResponseModel {
  bool? success;
  Data? data;
  String? message;

  GetUserJobLocationResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetUserJobLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      GetUserJobLocationResponseModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  Locationdetails? locationdetails;

  Data({
    this.locationdetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locationdetails: json["locationdetails"] == null
            ? null
            : Locationdetails.fromJson(json["locationdetails"]),
      );

  Map<String, dynamic> toJson() => {
        "locationdetails": locationdetails?.toJson(),
      };
}

class Locationdetails {
  int? id;
  String? name;
  String? address;
  dynamic qrCode;
  String? latitude;
  String? longitude;
  String? fenceRadius;
  String? notes;
  String? supportNumber;
  String? email;
  dynamic createdTime;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Locationdetails({
    this.id,
    this.name,
    this.address,
    this.qrCode,
    this.latitude,
    this.longitude,
    this.fenceRadius,
    this.notes,
    this.supportNumber,
    this.email,
    this.createdTime,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Locationdetails.fromJson(Map<String, dynamic> json) =>
      Locationdetails(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        qrCode: json["qr_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fenceRadius: json["fence_radius"],
        notes: json["notes"],
        supportNumber: json["support_number"],
        email: json["email"],
        createdTime: json["created_time"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "qr_code": qrCode,
        "latitude": latitude,
        "longitude": longitude,
        "fence_radius": fenceRadius,
        "notes": notes,
        "support_number": supportNumber,
        "email": email,
        "created_time": createdTime,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
