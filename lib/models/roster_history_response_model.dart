// To parse this JSON data, do
//
//     final rosterHistoryResponseModel = rosterHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

RosterHistoryResponseModel rosterHistoryResponseModelFromJson(String str) =>
    RosterHistoryResponseModel.fromJson(json.decode(str));

String rosterHistoryResponseModelToJson(RosterHistoryResponseModel data) =>
    json.encode(data.toJson());

class RosterHistoryResponseModel {
  bool? success;
  Data? data;
  String? message;

  RosterHistoryResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory RosterHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      RosterHistoryResponseModel(
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
  List<HistoryDate>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<HistoryDate>.from(
            json["data"].map((x) => HistoryDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryDate {
  int? id;
  int? userId;
  int? issuedBy;
  String? rotasDate;
  String? startTime;
  String? endTime;
  String? breakTime;
  String? timeDiffInMinut;
  int? roleId;
  int? locationId;
  String? note;
  int? publish;
  String? shiftStatus;
  dynamic shiftCancelEmployeeMsg;
  dynamic shiftCancelOwnerMsg;
  int? isAccepted;
  int? createBy;
  String? createdAt;
  String? updatedAt;
  Getrotauser? getrotauser;
  Getrotalocation? getrotalocation;

  HistoryDate({
    this.id,
    this.userId,
    this.issuedBy,
    this.rotasDate,
    this.startTime,
    this.endTime,
    this.breakTime,
    this.timeDiffInMinut,
    this.roleId,
    this.locationId,
    this.note,
    this.publish,
    this.shiftStatus,
    this.shiftCancelEmployeeMsg,
    this.shiftCancelOwnerMsg,
    this.isAccepted,
    this.createBy,
    this.createdAt,
    this.updatedAt,
    this.getrotauser,
    this.getrotalocation,
  });

  factory HistoryDate.fromJson(Map<String, dynamic> json) => HistoryDate(
        id: json["id"],
        userId: json["user_id"],
        issuedBy: json["issued_by"],
        rotasDate: json["rotas_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        breakTime: json["break_time"],
        timeDiffInMinut: json["time_diff_in_minut"],
        roleId: json["role_id"],
        locationId: json["location_id"],
        note: json["note"],
        publish: json["publish"],
        shiftStatus: json["shift_status"],
        shiftCancelEmployeeMsg: json["shift_cancel_employee_msg"],
        shiftCancelOwnerMsg: json["shift_cancel_owner_msg"],
        isAccepted: json["is_accepted"],
        createBy: json["create_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        getrotauser: Getrotauser.fromJson(json["getrotauser"]),
        getrotalocation: Getrotalocation.fromJson(json["getrotalocation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "issued_by": issuedBy,
        "rotas_date": rotasDate,
        "start_time": startTime,
        "end_time": endTime,
        "break_time": breakTime,
        "time_diff_in_minut": timeDiffInMinut,
        "role_id": roleId,
        "location_id": locationId,
        "note": note,
        "publish": publish,
        "shift_status": shiftStatus,
        "shift_cancel_employee_msg": shiftCancelEmployeeMsg,
        "shift_cancel_owner_msg": shiftCancelOwnerMsg,
        "is_accepted": isAccepted,
        "create_by": createBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "getrotauser": getrotauser,
        "getrotalocation": getrotalocation,
      };
}

class Getrotalocation {
  int? id;
  String? name;
  String? address;
  dynamic qrCode;
  String? latitude;
  String? longitude;
  String? fenceRadius;
  String? notes;
  dynamic supportNumber;
  String? email;
  dynamic createdTime;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Getrotalocation({
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

  factory Getrotalocation.fromJson(Map<String, dynamic> json) =>
      Getrotalocation(
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Getrotauser {
  int? id;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? companyName;
  String? type;
  String? email;
  String? emailVerifiedAt;
  int? issueBy;
  int? createdBy;
  int? acountType;
  dynamic managerPermission;
  String? companyDetail;
  String? companySetting;
  dynamic employeeSetting;
  String? lang;
  String? mode;
  int? isDelete;
  dynamic deletedAt;
  int? deletedBy;
  int? plan;
  double? companyStorage;
  dynamic planExpireDate;
  int? requestedPlan;
  String? createdAt;
  String? updatedAt;
  String? avatar;
  String? messengerColor;
  int? darkMode;
  int? activeStatus;

  Getrotauser({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.companyName,
    this.type,
    this.email,
    this.emailVerifiedAt,
    this.issueBy,
    this.createdBy,
    this.acountType,
    this.managerPermission,
    this.companyDetail,
    this.companySetting,
    this.employeeSetting,
    this.lang,
    this.mode,
    this.isDelete,
    this.deletedAt,
    this.deletedBy,
    this.plan,
    this.companyStorage,
    this.planExpireDate,
    this.requestedPlan,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.messengerColor,
    this.darkMode,
    this.activeStatus,
  });

  factory Getrotauser.fromJson(Map<String, dynamic> json) => Getrotauser(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        type: json["type"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        issueBy: json["issue_by"],
        createdBy: json["created_by"],
        acountType: json["acount_type"],
        managerPermission: json["manager_permission"],
        companyDetail: json["company_detail"],
        companySetting: json["company_setting"],
        employeeSetting: json["employee_setting"],
        lang: json["lang"],
        mode: json["mode"],
        isDelete: json["is_delete"],
        deletedAt: json["deleted_at"],
        deletedBy: json["deleted_by"],
        plan: json["plan"],
        companyStorage: json["company_storage"]?.toDouble(),
        planExpireDate: json["plan_expire_date"],
        requestedPlan: json["requested_plan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        avatar: json["avatar"],
        messengerColor: json["messenger_color"],
        darkMode: json["dark_mode"],
        activeStatus: json["active_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "company_name": companyName,
        "type": type,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "issue_by": issueBy,
        "created_by": createdBy,
        "acount_type": acountType,
        "manager_permission": managerPermission,
        "company_detail": companyDetail,
        "company_setting": companySetting,
        "employee_setting": employeeSetting,
        "lang": lang,
        "mode": mode,
        "is_delete": isDelete,
        "deleted_at": deletedAt,
        "deleted_by": deletedBy,
        "plan": plan,
        "company_storage": companyStorage,
        "plan_expire_date": planExpireDate,
        "requested_plan": requestedPlan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "avatar": avatar,
        "messenger_color": messengerColor,
        "dark_mode": darkMode,
        "active_status": activeStatus,
      };
}
