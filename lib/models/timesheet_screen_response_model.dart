// // To parse this JSON data, do
// //
// //     final timeSheetResponseModel = timeSheetResponseModelFromJson(jsonString);

// import 'dart:convert';

// TimeSheetResponseModel timeSheetResponseModelFromJson(String str) =>
//     TimeSheetResponseModel.fromJson(json.decode(str));

// String timeSheetResponseModelToJson(TimeSheetResponseModel data) =>
//     json.encode(data.toJson());

// class TimeSheetResponseModel {
//   bool? success;
//   Data? data;
//   String? message;

//   TimeSheetResponseModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   factory TimeSheetResponseModel.fromJson(Map<String, dynamic> json) =>
//       TimeSheetResponseModel(
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
//   List<Timesheet>? timeheet;

//   Data({
//     this.timeheet,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         timeheet: List<Timesheet>.from(
//             json["timeheet"].map((x) => Timesheet.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "timeheet": List<dynamic>.from(timeheet!.map((x) => x.toJson())),
//       };
// }

// class Timesheet {
//   int? id;
//   int? userId;
//   int? clockinbymap;
//   int? locationId;
//   String? userLat;
//   String? userLng;
//   String? date;
//   String? endDate;
//   String? status;
//   String? clockIn;
//   String? clockOut;
//   String? lates;
//   String? earlyLeaving;
//   String? overtime;
//   String? totalRest;
//   String? clockInStatus;
//   int? createdBy;
//   String? createdAt;
//   String? updatedAt;

//   Timesheet({
//     this.id,
//     this.userId,
//     this.clockinbymap,
//     this.locationId,
//     this.userLat,
//     this.userLng,
//     this.date,
//     this.endDate,
//     this.status,
//     this.clockIn,
//     this.clockOut,
//     this.lates,
//     this.earlyLeaving,
//     this.overtime,
//     this.totalRest,
//     this.clockInStatus,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Timesheet.fromJson(Map<String, dynamic> json) => Timesheet(
//         id: json["id"],
//         userId: json["user_id"],
//         clockinbymap: json["clockinbymap"],
//         locationId: json["location_id"],
//         userLat: json["user_lat"],
//         userLng: json["user_lng"],
//         date: json["date"],
//         endDate: json["end_date"],
//         status: json["status"],
//         clockIn: json["clock_in"],
//         clockOut: json["clock_out"],
//         lates: json["late"],
//         earlyLeaving: json["early_leaving"],
//         overtime: json["overtime"],
//         totalRest: json["total_rest"],
//         clockInStatus: json["clock_in_status"],
//         createdBy: json["created_by"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "clockinbymap": clockinbymap,
//         "location_id": locationId,
//         "user_lat": userLat,
//         "user_lng": userLng,
//         "date": date,
//         "end_date": endDate,
//         "status": status,
//         "clock_in": clockIn,
//         "clock_out": clockOut,
//         "late": lates,
//         "early_leaving": earlyLeaving,
//         "overtime": overtime,
//         "total_rest": totalRest,
//         "clock_in_status": clockInStatus,
//         "created_by": createdBy,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }


// To parse this JSON data, do
//
//     final timeSheetResponseModel = timeSheetResponseModelFromJson(jsonString);

import 'dart:convert';

TimeSheetResponseModel timeSheetResponseModelFromJson(String str) => TimeSheetResponseModel.fromJson(json.decode(str));

String timeSheetResponseModelToJson(TimeSheetResponseModel data) => json.encode(data.toJson());

class TimeSheetResponseModel {
    bool? success;
    List<TimeSheet>? data;
    String? message;

    TimeSheetResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory TimeSheetResponseModel.fromJson(Map<String, dynamic> json) => TimeSheetResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<TimeSheet>.from(json["data"]!.map((x) => TimeSheet.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class TimeSheet {
    int? id;
    int? userId;
    int? clockinbymap;
    String? userLat;
    String? userLng;
    int? locationId;
    DateTime? date;
    dynamic endDate;
    String? status;
    String? clockIn;
    String? clockOut;
    String? late;
    String? earlyLeaving;
    String? overtime;
    String? clockInStatus;
    String? totalRest;
    int? createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    TimeSheet({
        this.id,
        this.userId,
        this.clockinbymap,
        this.userLat,
        this.userLng,
        this.locationId,
        this.date,
        this.endDate,
        this.status,
        this.clockIn,
        this.clockOut,
        this.late,
        this.earlyLeaving,
        this.overtime,
        this.clockInStatus,
        this.totalRest,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
    });

    factory TimeSheet.fromJson(Map<String, dynamic> json) => TimeSheet(
        id: json["id"],
        userId: json["user_id"] is int ? json["user_id"] : int.parse(json["user_id"]),
        clockinbymap: json["clockinbymap"] is int ? json["clockinbymap"] : int.parse(json["clockinbymap"]),
        userLat: json["user_lat"],
        userLng: json["user_lng"],
        locationId: json["location_id"] is int ? json["location_id"] : int.parse(json["location_id"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        endDate: json["end_date"],
        status: json["status"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        late: json["late"],
        earlyLeaving: json["early_leaving"],
        overtime: json["overtime"],
        clockInStatus: json["clock_in_status"],
        totalRest: json["total_rest"],
        createdBy: json["created_by"] is int ? json["created_by"] : int.parse(json["created_by"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "clockinbymap": clockinbymap,
        "user_lat": userLat,
        "user_lng": userLng,
        "location_id": locationId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "status": status,
        "clock_in": clockIn,
        "clock_out": clockOut,
        "late": late,
        "early_leaving": earlyLeaving,
        "overtime": overtime,
        "clock_in_status": clockInStatus,
        "total_rest": totalRest,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
