// // To parse this JSON data, do
// //
// //     final getUserClockInOutApiResponeModel = getUserClockInOutApiResponeModelFromJson(jsonString);

// import 'dart:convert';

// GetUserClockInOutApiResponeModel getUserClockInOutApiResponeModelFromJson(
//         String str) =>
//     GetUserClockInOutApiResponeModel.fromJson(json.decode(str));

// String getUserClockInOutApiResponeModelToJson(
//         GetUserClockInOutApiResponeModel data) =>
//     json.encode(data.toJson());

// class GetUserClockInOutApiResponeModel {
//   bool? success;
//   Data? data;
//   String? message;

//   GetUserClockInOutApiResponeModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   factory GetUserClockInOutApiResponeModel.fromJson(
//           Map<String, dynamic> json) =>
//       GetUserClockInOutApiResponeModel(
//         success: json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data?.toJson(),
//         "message": message,
//       };
// }

// class Data {
//   int? isClockin;

//   Data({
//     this.isClockin,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         isClockin: json["is_clockin"],
//       );

//   Map<String, dynamic> toJson() => {
//         "is_clockin": isClockin,
//       };
// }


class GetUserClockInOutApiResponeModel {
  final bool success;
  final int data;
  final String message;

  GetUserClockInOutApiResponeModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetUserClockInOutApiResponeModel.fromJson(Map<String, dynamic> json) {
    return GetUserClockInOutApiResponeModel(
      success: json['success'] ?? false,
      data: json['data'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
    };
  }
}
