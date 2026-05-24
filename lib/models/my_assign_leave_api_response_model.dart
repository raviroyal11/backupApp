// To parse this JSON data, do
//
//     final myAssignLeaveListApiResponseModel = myAssignLeaveListApiResponseModelFromJson(jsonString);

import 'dart:convert';

MyAssignLeaveListApiResponseModel myAssignLeaveListApiResponseModelFromJson(String str) => MyAssignLeaveListApiResponseModel.fromJson(json.decode(str));

String myAssignLeaveListApiResponseModelToJson(MyAssignLeaveListApiResponseModel data) => json.encode(data.toJson());

class MyAssignLeaveListApiResponseModel {
    bool? success;
    List<MyAssignLeave>? data;
    String? message;

    MyAssignLeaveListApiResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory MyAssignLeaveListApiResponseModel.fromJson(Map<String, dynamic> json) => MyAssignLeaveListApiResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<MyAssignLeave>.from(json["data"]!.map((x) => MyAssignLeave.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class MyAssignLeave {
    int? leaveId;
    String? leaveName;
    String? slug;
    bool? assigned;
    String? total;
    int? used;
    int? remaining;

    MyAssignLeave({
        this.leaveId,
        this.leaveName,
        this.slug,
        this.assigned,
        this.total,
        this.used,
        this.remaining,
    });

    factory MyAssignLeave.fromJson(Map<String, dynamic> json) => MyAssignLeave(
        leaveId: json["leave_id"],
        leaveName: json["leave_name"],
        slug: json["slug"],
        assigned: json["assigned"],
        total: json["total"] is int ? json["total"].toString() : json["total"],
        used: json["used"],
        remaining: json["remaining"],
    );

    Map<String, dynamic> toJson() => {
        "leave_id": leaveId,
        "leave_name": leaveName,
        "slug": slug,
        "assigned": assigned,
        "total": total,
        "used": used,
        "remaining": remaining,
    };
}
