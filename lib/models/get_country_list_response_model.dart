// import 'dart:convert';

// GetCountryListResponseModel getCountryListResponseModelFromJson(String str) =>
//     GetCountryListResponseModel.fromJson(json.decode(str));

// String getCountryListResponseModelToJson(GetCountryListResponseModel data) =>
//     json.encode(data.toJson());

// class GetCountryListResponseModel {
//   bool? success;
//   Data? data;
//   String? message;

//   GetCountryListResponseModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   factory GetCountryListResponseModel.fromJson(Map<String, dynamic> json) =>
//       GetCountryListResponseModel(
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
//   List<CountryData> data;

//   Data({
//     required this.data,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         data: List<CountryData>.from(
//             json["data"].map((x) => CountryData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class CountryData {
//   int id;
//   String code;
//   String name;
//   dynamic isDeleted;
//   DateTime createdAt;
//   DateTime updatedAt;

//   CountryData({
//     required this.id,
//     required this.code,
//     required this.name,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
//         id: json["id"],
//         code: json["code"],
//         name: json["name"],
//         isDeleted: json["is_deleted"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "code": code,
//         "name": name,
//         "is_deleted": isDeleted,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final getCountryListResponseModel = getCountryListResponseModelFromJson(jsonString);

import 'dart:convert';

GetCountryListResponseModel getCountryListResponseModelFromJson(String str) => GetCountryListResponseModel.fromJson(json.decode(str));

String getCountryListResponseModelToJson(GetCountryListResponseModel data) => json.encode(data.toJson());

class GetCountryListResponseModel {
    bool? success;
    List<CountryData>? data;
    String? message;

    GetCountryListResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory GetCountryListResponseModel.fromJson(Map<String, dynamic> json) => GetCountryListResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<CountryData>.from(json["data"]!.map((x) => CountryData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class CountryData {
    int? id;
    String? name;
    String? shortCode;
    String? phoneCode;
    dynamic createdAt;
    dynamic updatedAt;

    CountryData({
        this.id,
        this.name,
        this.shortCode,
        this.phoneCode,
        this.createdAt,
        this.updatedAt,
    });

    factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        id: json["id"],
        name: json["name"],
        shortCode: json["short_code"],
        phoneCode: json["phone_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_code": shortCode,
        "phone_code": phoneCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

