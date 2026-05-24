// // To parse this JSON data, do
// //
// //     final getRosterScreenLocationResponseModel = getRosterScreenLocationResponseModelFromJson(jsonString);

// import 'dart:convert';

// GetRosterScreenLocationResponseModel
//     getRosterScreenLocationResponseModelFromJson(String str) =>
//         GetRosterScreenLocationResponseModel.fromJson(json.decode(str));

// String getRosterScreenLocationResponseModelToJson(
//         GetRosterScreenLocationResponseModel data) =>
//     json.encode(data.toJson());

// class GetRosterScreenLocationResponseModel {
//   bool? success;
//   Data? data;
//   String? message;

//   GetRosterScreenLocationResponseModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   factory GetRosterScreenLocationResponseModel.fromJson(
//           Map<String, dynamic> json) =>
//       GetRosterScreenLocationResponseModel(
//         success: json["success"],
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data?.toJson(),
//         "message": message,
//       };
// }

// class Data {
//   List<LocationDataList>? data;

//   Data({
//     this.data,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         data: List<LocationDataList>.from(
//             json["data"].map((x) => LocationDataList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class LocationDataList {
//   int? id;
//   String? name;
//   String? address;
//   dynamic qrCode;
//   dynamic latitude;
//   dynamic longitude;
//   String? fenceRadius;
//   String? notes;
//   String? supportNumber;
//   String? email;
//   dynamic createdTime;
//   int? createdBy;
//   String? createdAt;
//   String? updatedAt;

//   LocationDataList({
//     this.id,
//     this.name,
//     this.address,
//     this.qrCode,
//     this.latitude,
//     this.longitude,
//     this.fenceRadius,
//     this.notes,
//     this.supportNumber,
//     this.email,
//     this.createdTime,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory LocationDataList.fromJson(Map<String, dynamic> json) =>
//       LocationDataList(
//         id: json["id"],
//         name: json["name"],
//         address: json["address"],
//         qrCode: json["qr_code"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         fenceRadius: json["fence_radius"],
//         notes: json["notes"],
//         supportNumber: json["support_number"],
//         email: json["email"],
//         createdTime: json["created_time"],
//         createdBy: json["created_by"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "address": address,
//         "qr_code": qrCode,
//         "latitude": latitude,
//         "longitude": longitude,
//         "fence_radius": fenceRadius,
//         "notes": notes,
//         "support_number": supportNumber,
//         "email": email,
//         "created_time": createdTime,
//         "created_by": createdBy,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }


// To parse this JSON data, do
//
//     final getRosterScreenLocationResponseModel = getRosterScreenLocationResponseModelFromJson(jsonString);

import 'dart:convert';

GetRosterScreenLocationResponseModel getRosterScreenLocationResponseModelFromJson(String str) => GetRosterScreenLocationResponseModel.fromJson(json.decode(str));

String getRosterScreenLocationResponseModelToJson(GetRosterScreenLocationResponseModel data) => json.encode(data.toJson());

class GetRosterScreenLocationResponseModel {
    bool? success;
    List<LocationDataList>? data;
    String? message;

    GetRosterScreenLocationResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory GetRosterScreenLocationResponseModel.fromJson(Map<String, dynamic> json) => GetRosterScreenLocationResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<LocationDataList>.from(json["data"]!.map((x) => LocationDataList.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class LocationDataList {
    int? id;
    int? companyId;
    String? locationName;
    String? address;
    String? fenceRadius;
    String? supportEmail;
    String? supportContact;
    String? email;
    String? notes;
    String? employee;
    int? status;
    String? loginUrl;
    String? qrCode;
    DateTime? createdAt;
    DateTime? updatedAt;

    LocationDataList({
        this.id,
        this.companyId,
        this.locationName,
        this.address,
        this.fenceRadius,
        this.supportEmail,
        this.supportContact,
        this.email,
        this.notes,
        this.employee,
        this.status,
        this.loginUrl,
        this.qrCode,
        this.createdAt,
        this.updatedAt,
    });

    factory LocationDataList.fromJson(Map<String, dynamic> json) => LocationDataList(
        id: json["id"],
        companyId: json["company_id"] is int ? json["company_id"] : int.parse(json["company_id"]),
        locationName: json["location_name"],
        address: json["address"],
        fenceRadius: json["fence_radius"],
        supportEmail: json["support_email"],
        supportContact: json["support_contact"],
        email: json["email"],
        notes: json["notes"],
        employee: json["employee"],
        status: json["status"] is int ? json["status"] : int.parse(json["status"]),
        loginUrl: json["login_url"],
        qrCode: json["qr_code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "location_name": locationName,
        "address": address,
        "fence_radius": fenceRadius,
        "support_email": supportEmail,
        "support_contact": supportContact,
        "email": email,
        "notes": notes,
        "employee": employee,
        "status": status,
        "login_url": loginUrl,
        "qr_code": qrCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
