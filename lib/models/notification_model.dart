// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) => json.encode(data.toJson());

class NotificationResponseModel {
    bool? success;
    List<NotificationModel>? data;
    String? message;

    NotificationResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class NotificationModel {
    int? id;
    String? title;
    String? description;
    String? userType;
    String? userId;
    String? priority;
    String? status;
    String? createdBy;
    dynamic updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? statusText;
    String? statusColor;

    NotificationModel({
        this.id,
        this.title,
        this.description,
        this.userType,
        this.userId,
        this.priority,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.statusText,
        this.statusColor,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        description:  json["description"],
        userType: json["user_type"],
        userId: json["user_id"],
        priority: json["priority"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        statusText: json["status_text"],
        statusColor: json["status_color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "user_type": userType,
        "user_id": userId,
        "priority": priority,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status_text": statusText,
        "status_color": statusColor,
    };

}
