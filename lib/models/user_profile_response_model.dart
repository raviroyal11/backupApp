// To parse this JSON data, do
//
//     final userProfileResponseModel = userProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UserProfileResponseModel userProfileResponseModelFromJson(String str) => UserProfileResponseModel.fromJson(json.decode(str));

String userProfileResponseModelToJson(UserProfileResponseModel data) => json.encode(data.toJson());

class UserProfileResponseModel {
    int? id;
    String? firstName;
    String? lastName;
    String? email;
    dynamic countryCode;
    String? phone;
    DateTime? emailVerifiedAt;
    String? dob;
    String? gender;
    String? countryId;
    String? stateId;
    String? cityId;
    dynamic pincode;
    String? isActive;
    String? isVerified;
    String? roleId;
    String? language;
    String? profileViews;
    String? themeMode;
    String? createdByCompany;
    dynamic loginStatus;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? facebookUrl;
    String? twitterUrl;
    String? linkedinUrl;
    String? googlePlusUrl;
    String? pinterestUrl;
    String? isDefault;
    dynamic stripeId;
    dynamic regionCode;
    String? profileLogo;

    UserProfileResponseModel({
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
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

    factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) => UserProfileResponseModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        dob: json["dob"] == null ? '' : json["dob"],
        gender: json["gender"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        pincode: json["pincode"],
        isActive: json["is_active"],
        isVerified: json["is_verified"],
        roleId: json["role_id"],
        language: json["language"],
        profileViews: json["profile_views"],
        themeMode: json["theme_mode"],
        createdByCompany: json["created_by_company"],
        loginStatus: json["login_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        linkedinUrl: json["linkedin_url"],
        googlePlusUrl: json["google_plus_url"],
        pinterestUrl: json["pinterest_url"],
        isDefault: json["is_default"],
        stripeId: json["stripe_id"],
        regionCode: json["region_code"],
        profileLogo: json["profile_logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
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
