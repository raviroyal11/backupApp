// import 'dart:convert';

// import 'package:get/get.dart';

// RosterScreenResponseModel rosterScreenResponseModelFromJson(String str) =>
//     RosterScreenResponseModel.fromJson(json.decode(str));

// String rosterScreenResponseModelToJson(RosterScreenResponseModel data) =>
//     json.encode(data.toJson());

// class RosterScreenResponseModel {
//   bool? success;
//   RosterData? data;
//   String? message;

//   RosterScreenResponseModel({
//     this.success,
//     this.data,
//     this.message,
//   });

//   factory RosterScreenResponseModel.fromJson(Map<String, dynamic> json) =>
//       RosterScreenResponseModel(
//         success: json["success"],
//         data: json["data"] == null ? null : RosterData.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data?.toJson(),
//         "message": message,
//       };
// }

// class RosterData {
//   List<RosterDataList>? data;

//   RosterData({
//     this.data,
//   });

//   factory RosterData.fromJson(Map<String, dynamic> json) => RosterData(
//         data: json["data"] == null
//             ? []
//             : List<RosterDataList>.from(
//                 json["data"]!.map((x) => RosterDataList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class RosterDataList {
//   int? id;
//   int? userId;
//   int? issuedBy;
//   String? rotasDate;
//   String? startTime;
//   String? endTime;
//   String? breakTime;
//   String? timeDiffInMinut;
//   int? roleId;
//   int? locationId;
//   dynamic note;
//   int? publish;
//   String? shiftStatus;
//   dynamic shiftCancelEmployeeMsg;
//   dynamic shiftCancelOwnerMsg;
//   int? isAccepted;
//   int? isRejected;
//   String? averagerating;
//   int? createBy;
//   String? createdAt;
//   String? updatedAt;
//   Getrotauser? getrotauser;
//   Getrotalocation? getrotalocation;
//   RxBool isAcceptRoster;
//   RxBool isRejectRoster;

//   RosterDataList({
//     this.id,
//     this.userId,
//     this.issuedBy,
//     this.rotasDate,
//     this.startTime,
//     this.endTime,
//     this.breakTime,
//     this.timeDiffInMinut,
//     this.roleId,
//     this.locationId,
//     this.note,
//     this.publish,
//     this.shiftStatus,
//     this.shiftCancelEmployeeMsg,
//     this.shiftCancelOwnerMsg,
//     this.isAccepted,
//     this.isRejected,
//     this.averagerating,
//     this.createBy,
//     this.createdAt,
//     this.updatedAt,
//     this.getrotauser,
//     this.getrotalocation,
//     required this.isAcceptRoster,
//     required this.isRejectRoster,
//   });

//   factory RosterDataList.fromJson(Map<String, dynamic> json) => RosterDataList(
//         id: json["id"],
//         userId: json["user_id"],
//         issuedBy: json["issued_by"],
//         rotasDate: json["rotas_date"],
//         startTime: json["start_time"],
//         endTime: json["end_time"],
//         breakTime: json["break_time"],
//         timeDiffInMinut: json["time_diff_in_minut"],
//         roleId: json["role_id"],
//         locationId: json["location_id"],
//         note: json["note"],
//         publish: json["publish"],
//         shiftStatus: json["shift_status"],
//         shiftCancelEmployeeMsg: json["shift_cancel_employee_msg"],
//         shiftCancelOwnerMsg: json["shift_cancel_owner_msg"],
//         isAccepted: json["is_accepted"],
//         averagerating:
//             json["average_rating"] == null ? "0.0" : json["average_rating"],
//         isRejected: json["is_rejected"] == null ? 0 : json["is_rejected"],
//         createBy: json["create_by"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         getrotauser: json["getrotauser"] == null
//             ? null
//             : Getrotauser.fromJson(json["getrotauser"]),
//         getrotalocation: json["getrotalocation"] == null
//             ? null
//             : Getrotalocation.fromJson(json["getrotalocation"]),
//         isAcceptRoster: false.obs,
//         isRejectRoster: false.obs,
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "issued_by": issuedBy,
//         "rotas_date": rotasDate,
//         "start_time": startTime,
//         "end_time": endTime,
//         "break_time": breakTime,
//         "time_diff_in_minut": timeDiffInMinut,
//         "role_id": roleId,
//         "location_id": locationId,
//         "note": note,
//         "publish": publish,
//         "shift_status": shiftStatus,
//         "shift_cancel_employee_msg": shiftCancelEmployeeMsg,
//         "shift_cancel_owner_msg": shiftCancelOwnerMsg,
//         "is_accepted": isAccepted,
//         "average_rating": averagerating,
//         "is_rejected": isAccepted,
//         "create_by": createBy,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "getrotauser": getrotauser?.toJson(),
//         "getrotalocation": getrotalocation?.toJson(),
//       };
// }

// class Getrotalocation {
//   int? id;
//   String? name;
//   String? address;
//   dynamic qrCode;
//   String? latitude;
//   String? longitude;
//   String? fenceRadius;
//   String? notes;
//   String? supportNumber;
//   String? email;
//   dynamic createdTime;
//   int? createdBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Getrotalocation({
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

//   factory Getrotalocation.fromJson(Map<String, dynamic> json) =>
//       Getrotalocation(
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
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
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
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

// class Getrotauser {
//   int? id;
//   String? firstName;
//   dynamic middleName;
//   String? lastName;
//   String? companyName;
//   String? type;
//   String? email;
//   DateTime? emailVerifiedAt;
//   int? issueBy;
//   int? createdBy;
//   int? acountType;
//   dynamic managerPermission;
//   dynamic companyDetail;
//   dynamic companySetting;
//   dynamic employeeSetting;
//   String? lang;
//   String? mode;
//   int? isDelete;
//   dynamic deletedAt;
//   int? deletedBy;
//   dynamic plan;
//   int? companyStorage;
//   dynamic planExpireDate;
//   int? requestedPlan;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? avatar;
//   String? messengerColor;
//   int? darkMode;
//   int? activeStatus;

//   Getrotauser({
//     this.id,
//     this.firstName,
//     this.middleName,
//     this.lastName,
//     this.companyName,
//     this.type,
//     this.email,
//     this.emailVerifiedAt,
//     this.issueBy,
//     this.createdBy,
//     this.acountType,
//     this.managerPermission,
//     this.companyDetail,
//     this.companySetting,
//     this.employeeSetting,
//     this.lang,
//     this.mode,
//     this.isDelete,
//     this.deletedAt,
//     this.deletedBy,
//     this.plan,
//     this.companyStorage,
//     this.planExpireDate,
//     this.requestedPlan,
//     this.createdAt,
//     this.updatedAt,
//     this.avatar,
//     this.messengerColor,
//     this.darkMode,
//     this.activeStatus,
//   });

//   factory Getrotauser.fromJson(Map<String, dynamic> json) => Getrotauser(
//         id: json["id"],
//         firstName: json["first_name"],
//         middleName: json["middle_name"],
//         lastName: json["last_name"],
//         companyName: json["company_name"],
//         type: json["type"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"] == null
//             ? null
//             : DateTime.parse(json["email_verified_at"]),
//         issueBy: json["issue_by"],
//         createdBy: json["created_by"],
//         acountType: json["acount_type"],
//         managerPermission: json["manager_permission"],
//         companyDetail: json["company_detail"],
//         companySetting: json["company_setting"],
//         employeeSetting: json["employee_setting"],
//         lang: json["lang"],
//         mode: json["mode"],
//         isDelete: json["is_delete"],
//         deletedAt: json["deleted_at"],
//         deletedBy: json["deleted_by"],
//         plan: json["plan"],
//         companyStorage: json["company_storage"],
//         planExpireDate: json["plan_expire_date"],
//         requestedPlan: json["requested_plan"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         avatar: json["avatar"],
//         messengerColor: json["messenger_color"],
//         darkMode: json["dark_mode"],
//         activeStatus: json["active_status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "middle_name": middleName,
//         "last_name": lastName,
//         "company_name": companyName,
//         "type": type,
//         "email": email,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "issue_by": issueBy,
//         "created_by": createdBy,
//         "acount_type": acountType,
//         "manager_permission": managerPermission,
//         "company_detail": companyDetail,
//         "company_setting": companySetting,
//         "employee_setting": employeeSetting,
//         "lang": lang,
//         "mode": mode,
//         "is_delete": isDelete,
//         "deleted_at": deletedAt,
//         "deleted_by": deletedBy,
//         "plan": plan,
//         "company_storage": companyStorage,
//         "plan_expire_date": planExpireDate,
//         "requested_plan": requestedPlan,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "avatar": avatar,
//         "messenger_color": messengerColor,
//         "dark_mode": darkMode,
//         "active_status": activeStatus,
//       };
// }

// To parse this JSON data, do
//
//     final rosterScreenResponseModel = rosterScreenResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

RosterScreenResponseModel rosterScreenResponseModelFromJson(String str) => RosterScreenResponseModel.fromJson(json.decode(str));

String rosterScreenResponseModelToJson(RosterScreenResponseModel data) => json.encode(data.toJson());

class RosterScreenResponseModel {
    bool? success;
    List<RosterDataList>? data;
    String? message;

    RosterScreenResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory RosterScreenResponseModel.fromJson(Map<String, dynamic> json) => RosterScreenResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<RosterDataList>.from(json["data"]!.map((x) => RosterDataList.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class RosterDataList {
    int? id;
    int? userId;
    int? issuedBy;
    String? rotasDate;
    String? startTime;
    String? endTime;
    String? breakTime;
    dynamic restTime;
    String? timeDiffInMinut;
    int? roleId;
    int? locationId;
    String? note;
    int? publish;
    String? shiftStatus;
    dynamic shiftCancelEmployeeMsg;
    dynamic shiftCancelOwnerMsg;
    int? createdBy;
    int? isAccepted;
    dynamic averageRating;
    DateTime? createdAt;
    DateTime? updatedAt;
    Getrotauser? getrotauser;
    Getrotalocation? getrotalocation;
    RxBool isAcceptRoster;
    RxBool isRejectRoster;

    RosterDataList({
        this.id,
        this.userId,
        this.issuedBy,
        this.rotasDate,
        this.startTime,
        this.endTime,
        this.breakTime,
        this.restTime,
        this.timeDiffInMinut,
        this.roleId,
        this.locationId,
        this.note,
        this.publish,
        this.shiftStatus,
        this.shiftCancelEmployeeMsg,
        this.shiftCancelOwnerMsg,
        this.createdBy,
        this.isAccepted,
        this.averageRating,
        this.createdAt,
        this.updatedAt,
        this.getrotauser,
        this.getrotalocation,
        required this.isAcceptRoster,
        required this.isRejectRoster,
    });

    factory RosterDataList.fromJson(Map<String, dynamic> json) => RosterDataList(
        id: json["id"],
        userId: json["user_id"] is int ? json["user_id"] : int.parse(json["user_id"]),
        issuedBy: json["issued_by"] is int ? json["issued_by"] : int.parse(json["issued_by"]),
        rotasDate: json["rotas_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        breakTime: json["break_time"],
        restTime: json["rest_time"],
        timeDiffInMinut: json["time_diff_in_minut"],
        roleId: json["role_id"] is int ? json["role_id"] : int.parse(json["role_id"]),
        locationId: json["location_id"] is int ? json["location_id"] : int.parse(json["location_id"]),
        note: json["note"],
        publish: json["publish"] is int ? json["publish"] : int.parse(json["publish"]),
        shiftStatus: json["shift_status"],
        shiftCancelEmployeeMsg: json["shift_cancel_employee_msg"],
        shiftCancelOwnerMsg: json["shift_cancel_owner_msg"],
        createdBy: json["created_by"] is int ? json["created_by"] : int.parse(json["created_by"]),
        isAccepted: json["is_accepted"] is int ? json["is_accepted"] : int.parse(json["is_accepted"]),
        averageRating: json["average_rating"] == null ? 0 : json["average_rating"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        getrotauser: json["getrotauser"] == null ? null : Getrotauser.fromJson(json["getrotauser"] as Map<String, dynamic>),
        getrotalocation: json["getrotalocation"] == null ? null : Getrotalocation.fromJson(json["getrotalocation"]),
        isAcceptRoster: false.obs,
        isRejectRoster: false.obs,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "issued_by": issuedBy,
        "rotas_date": rotasDate,
        "start_time": startTime,
        "end_time": endTime,
        "break_time": breakTime,
        "rest_time": restTime,
        "time_diff_in_minut": timeDiffInMinut,
        "role_id": roleId,
        "location_id": locationId,
        "note": note,
        "publish": publish,
        "shift_status": shiftStatus,
        "shift_cancel_employee_msg": shiftCancelEmployeeMsg,
        "shift_cancel_owner_msg": shiftCancelOwnerMsg,
        "created_by": createdBy,
        "is_accepted": isAccepted,
        "average_rating": averageRating,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "getrotauser": getrotauser?.toJson(),
        "getrotalocation": getrotalocation?.toJson(),
    };
}

class Getrotalocation {
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

    Getrotalocation({
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

    factory Getrotalocation.fromJson(Map<String, dynamic> json) => Getrotalocation(
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

class Getrotauser {
    int? id;
    String? firstName;
    dynamic lastName;
    String? email;
    String? phone;
    dynamic emailVerifiedAt;
    dynamic dob;
    dynamic gender;
    dynamic countryId;
    dynamic stateId;
    dynamic cityId;
    dynamic pincode;
    int? isActive;
    int? isVerified;
    int? roleId;
    String? language;
    int? profileViews;
    String? themeMode;
    int? createdByCompany;
    dynamic loginStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic facebookUrl;
    dynamic twitterUrl;
    dynamic linkedinUrl;
    dynamic googlePlusUrl;
    dynamic pinterestUrl;
    int? isDefault;
    dynamic stripeId;
    dynamic regionCode;
    dynamic profileLogo;

    Getrotauser({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.dob,
        this.gender,
        this.countryId,
        this.stateId,
        this.cityId,
        this.pincode,
        this.isActive,
        this.isVerified,
        this.roleId,
        this.language,
        this.profileViews,
        this.themeMode,
        this.createdByCompany,
        this.loginStatus,
        this.createdAt,
        this.updatedAt,
        this.facebookUrl,
        this.twitterUrl,
        this.linkedinUrl,
        this.googlePlusUrl,
        this.pinterestUrl,
        this.isDefault,
        this.stripeId,
        this.regionCode,
        this.profileLogo,
    });

    factory Getrotauser.fromJson(Map<String, dynamic> json) => Getrotauser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        dob: json["dob"],
        gender: json["gender"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        pincode: json["pincode"],
        isActive: json["is_active"] is int ? json["is_active"] : int.parse(json["is_active"]),
        isVerified: json["is_verified"] is int ? json["is_verified"] : int.parse(json["is_verified"]),
        roleId: json["role_id"] is int ? json["role_id"] : int.parse(json["role_id"]),
        language: json["language"],
        profileViews: json["profile_views"] is int ? json["profile_views"] : int.parse(json["profile_views"]),
        themeMode: json["theme_mode"],
        createdByCompany: json["created_by_company"] is int ? json["created_by_company"] : int.parse(json["created_by_company"]),
        loginStatus: json["login_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        linkedinUrl: json["linkedin_url"],
        googlePlusUrl: json["google_plus_url"],
        pinterestUrl: json["pinterest_url"],
        isDefault: json["is_default"] is int ? json["is_default"] : int.parse(json["is_default"]),
        stripeId: json["stripe_id"] == null ? null : json["stripe_id"] is int ? json["stripe_id"] : int.parse(json["stripe_id"]),
        regionCode: json["region_code"],
        profileLogo: json["profile_logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "dob": dob,
        "gender": gender,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "pincode": pincode,
        "is_active": isActive,
        "is_verified": isVerified,
        "role_id": roleId,
        "language": language,
        "profile_views": profileViews,
        "theme_mode": themeMode,
        "created_by_company": createdByCompany,
        "login_status": loginStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "linkedin_url": linkedinUrl,
        "google_plus_url": googlePlusUrl,
        "pinterest_url": pinterestUrl,
        "is_default": isDefault,
        "stripe_id": stripeId,
        "region_code": regionCode,
        "profile_logo": profileLogo,
    };
}
