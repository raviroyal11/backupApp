// To parse this JSON data, do
//
//     final clockInResponseModel = clockInResponseModelFromJson(jsonString);

import 'dart:convert';

ClockInResponseModel clockInResponseModelFromJson(String str) =>
    ClockInResponseModel.fromJson(json.decode(str));

String clockInResponseModelToJson(ClockInResponseModel data) =>
    json.encode(data.toJson());

class ClockInResponseModel {
  bool success;
  Data data;
  String message;

  ClockInResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ClockInResponseModel.fromJson(Map<String, dynamic> json) =>
      ClockInResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  String message;
  int clockInId;

  Data({
    required this.message,
    required this.clockInId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        clockInId: json["clockInID"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "clockInID": clockInId,
      };
}
