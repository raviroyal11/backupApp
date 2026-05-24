// To parse this JSON data, do
//
//     final registerApiResponseModel = registerApiResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterApiResponseModel registerApiResponseModelFromJson(String str) => RegisterApiResponseModel.fromJson(json.decode(str));

String registerApiResponseModelToJson(RegisterApiResponseModel data) => json.encode(data.toJson());

class RegisterApiResponseModel {
    String? accessToken;
    String? tokenType;
    int? expiresIn;
    User? user;

    RegisterApiResponseModel({
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.user,
    });

    factory RegisterApiResponseModel.fromJson(Map<String, dynamic> json) => RegisterApiResponseModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": user?.toJson(),
    };
}

class User {
    String? firstName;
    String? email;
    String? phone;
    int? isVerified;
    int? roleId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? id;

    User({
        this.firstName,
        this.email,
        this.phone,
        this.isVerified,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        email: json["email"],
        phone: json["phone"],
        isVerified: json["is_verified"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "email": email,
        "phone": phone,
        "is_verified": isVerified,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
    };
}
