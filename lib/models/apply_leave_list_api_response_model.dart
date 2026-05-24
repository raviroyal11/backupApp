// To parse this JSON data, do
//
//     final leaveListApiResponseModel = leaveListApiResponseModelFromJson(jsonString);

import 'dart:convert';

LeaveListApiResponseModel leaveListApiResponseModelFromJson(String str) => LeaveListApiResponseModel.fromJson(json.decode(str));

String leaveListApiResponseModelToJson(LeaveListApiResponseModel data) => json.encode(data.toJson());

class LeaveListApiResponseModel {
    bool? success;
    List<LeaveApplication>? data;
    String? message;

    LeaveListApiResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory LeaveListApiResponseModel.fromJson(Map<String, dynamic> json) => LeaveListApiResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<LeaveApplication>.from(json["data"]!.map((x) => LeaveApplication.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class LeaveApplication {
    int? id;
    String? userId;
    String? companyId;
    String? leaveType;
    String? duration;
    DateTime? fromDate;
    DateTime? toDate;
    String? days;
    String? reason;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? statusText;
    String? statusColor;
    String? leaveTypeName;

    LeaveApplication({
        this.id,
        this.userId,
        this.companyId,
        this.leaveType,
        this.duration,
        this.fromDate,
        this.toDate,
        this.days,
        this.reason,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.statusText,
        this.statusColor,
        this.leaveTypeName,
    });

    factory LeaveApplication.fromJson(Map<String, dynamic> json) => LeaveApplication(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        leaveType: json["leave_type"],
        duration: json["duration"],
        fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
        toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        days: json["days"],
        reason: json["reason"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        statusText: json["status_text"],
        statusColor: json["status_color"],
        leaveTypeName: json["leave_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "leave_type": leaveType,
        "duration": duration,
        "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "days": days,
        "reason": reason,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status_text": statusText,
        "status_color": statusColor,
        "leave_type_name": leaveTypeName,
    };
}
