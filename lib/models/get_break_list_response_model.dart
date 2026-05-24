// To parse this JSON data, do
//
//     final BreackScreenHistroyListResponseModel = BreackScreenHistroyListResponseModelFromJson(jsonString);

import 'dart:convert';

BreackScreenHistroyListResponseModel
    breackScreenHistroyListResponseModelFromJson(String str) =>
        BreackScreenHistroyListResponseModel.fromJson(json.decode(str));

String breackScreenHistroyListResponseModelToJson(
        BreackScreenHistroyListResponseModel data) =>
    json.encode(data.toJson());

class BreackScreenHistroyListResponseModel {
  bool? success;
  Data? data;
  String? message;

  BreackScreenHistroyListResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory BreackScreenHistroyListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      BreackScreenHistroyListResponseModel(
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
  List<BreakListData>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<BreakListData>.from(
            json["data"].map((x) => BreakListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BreakListData {
  int? id;
  int? userId;
  int? attendancesId;
  String? clockIn;
  String? clockOut;
  String? createdAt;

  BreakListData({
    this.id,
    this.userId,
    this.attendancesId,
    this.clockIn,
    this.clockOut,
    this.createdAt,
  });

  factory BreakListData.fromJson(Map<String, dynamic> json) => BreakListData(
        id: json["id"],
        userId: json["user_id"],
        attendancesId: json["attendances_id"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "attendances_id": attendancesId,
        "clock_in": clockIn,
        "clock_out": clockOut,
        "created_at": createdAt,
      };
}
