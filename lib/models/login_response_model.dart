// // To parse this JSON data, do
// //
// //     final loginResponseModel = loginResponseModelFromJson(jsonString);

// import 'dart:convert';

// LoginResponseModel loginResponseModelFromJson(String str) =>
//     LoginResponseModel.fromJson(json.decode(str));

// String loginResponseModelToJson(LoginResponseModel data) =>
//     json.encode(data.toJson());

// class LoginResponseModel {
//   // bool success;
//   Data data;
//   String message;

//   LoginResponseModel({
//     // required this.success,
//     required this.data,
//     required this.message,
//   });

//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
//       LoginResponseModel(
//         // success: json["success"],
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         // "success": success,
//         "data": data.toJson(),
//         "message": message,
//       };
// }

// class Data {
//   int id;
//   String name;
//   String email;
//   String dob;
//   String mobile;

//   Data({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.dob,
//     required this.mobile,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"] == "" ? "" : json["id"],
//         name: json["name"] == "" ? "" : json["name"],
//         email: json["email"] == "" ? "" : json["email"],
//         dob: json["dob"] == null ? "" : json["dob"],
//         mobile: json["mobile"] == "" ? "" : json["mobile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "dob": dob,
//         "mobile": mobile,
//       };
// }


// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? accessToken;
    String? tokenType;
    int? expiresIn;
    User? data;

    LoginResponseModel({
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.data,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        data: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": data?.toJson(),
    };
}

class User {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    String? phone;
    DateTime? emailVerifiedAt;
    String? dob;
    String? gender;
    int? countryId;
    int? stateId;
    int? cityId;
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
    String? profileLogo;

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        dob: json["dob"] ?? '',
        gender: json["gender"],
        countryId: json["country_id"] is int ? json["country_id"] : int.tryParse(json["country_id"].toString()),
        stateId: json["state_id"] is int ? json["state_id"] : int.tryParse(json["state_id"].toString()),
        cityId: json["city_id"] is int ? json["city_id"] : int.tryParse(json["city_id"].toString()),
        pincode: json["pincode"],
        isActive: json["is_active"] is int ? json["is_active"] : int.tryParse(json["is_active"].toString()),
        isVerified: json["is_verified"] is int ? json["is_verified"] : int.tryParse(json["is_verified"].toString()),
        roleId: json["role_id"] is int ? json["role_id"] : int.tryParse(json["role_id"].toString()),
        language: json["language"],
        profileViews: json["profile_views"] is int ? json["profile_views"] : int.tryParse(json["profile_views"].toString()),
        themeMode: json["theme_mode"],
        createdByCompany: json["created_by_company"] is int ? json["created_by_company"] : int.tryParse(json["created_by_company"].toString()),
        loginStatus: json["login_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        linkedinUrl: json["linkedin_url"],
        googlePlusUrl: json["google_plus_url"],
        pinterestUrl: json["pinterest_url"],
        isDefault: json["is_default"] is int ? json["is_default"] : int.tryParse(json["is_default"].toString()),
        stripeId: json["stripe_id"],
        regionCode: json["region_code"],
        profileLogo: json["profile_logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
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
