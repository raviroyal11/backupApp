// To parse this JSON data, do
//
//     final jobSaveApiResponseModel = jobSaveApiResponseModelFromJson(jsonString);

import 'dart:convert';

JobSaveApiResponseModel jobSaveApiResponseModelFromJson(String str) => JobSaveApiResponseModel.fromJson(json.decode(str));

String jobSaveApiResponseModelToJson(JobSaveApiResponseModel data) => json.encode(data.toJson());

class JobSaveApiResponseModel {
    bool? success;
    String? message;
    Data? data;

    JobSaveApiResponseModel({
        this.success,
        this.message,
        this.data,
    });

    factory JobSaveApiResponseModel.fromJson(Map<String, dynamic> json) => JobSaveApiResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? userId;
    String? jobTitle;
    String? slug;
    JobType? jobType;
    String? jobCategory;
    String? description;
    String? noOfWorkers;
    int? licenseRequired;
    String? experience;
    String? qualificationRequired;
    String? location;
    String? payTypeRequired;
    String? priceFrom;
    String? priceTo;
    String? employerQuestionStatus;
    String? employerQuestions;
    String? companyPaymentStatus;
    String? paymentPlanType;
    String? paymentPlane;
    String? contactCompanyName;
    String? contactEmail;
    String? contactPhone;
    String? contactCountry;
    String? contactState;
    String? contactCity;
    String? contactZip;
    String? contactWebsite;
    String? contactAddress;
    String? status;
    String? logo;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    JobExperience? jobExperience;

    Data({
        this.id,
        this.userId,
        this.jobTitle,
        this.slug,
        this.jobType,
        this.jobCategory,
        this.description,
        this.noOfWorkers,
        this.licenseRequired,
        this.experience,
        this.qualificationRequired,
        this.location,
        this.payTypeRequired,
        this.priceFrom,
        this.priceTo,
        this.employerQuestionStatus,
        this.employerQuestions,
        this.companyPaymentStatus,
        this.paymentPlanType,
        this.paymentPlane,
        this.contactCompanyName,
        this.contactEmail,
        this.contactPhone,
        this.contactCountry,
        this.contactState,
        this.contactCity,
        this.contactZip,
        this.contactWebsite,
        this.contactAddress,
        this.status,
        this.logo,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.jobExperience,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        jobTitle: json["job_title"],
        slug: json["slug"],
        jobType: json["job_type"] == null ? null : JobType.fromJson(json["job_type"]),
        jobCategory: json["job_category"],
        description: json["description"],
        noOfWorkers: json["no_of_workers"],
        licenseRequired: json["license_required"],
        experience: json["experience"],
        qualificationRequired: json["qualification_required"],
        location: json["location"],
        payTypeRequired: json["pay_type_required"],
        priceFrom: json["price_from"],
        priceTo: json["price_to"],
        employerQuestionStatus: json["employer_question_status"],
        employerQuestions: json["employer_questions"],
        companyPaymentStatus: json["company_payment_status"],
        paymentPlanType: json["payment_plan_type"],
        paymentPlane: json["payment_plane"],
        contactCompanyName: json["contact_company_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        contactCountry: json["contact_country"],
        contactState: json["contact_state"],
        contactCity: json["contact_city"],
        contactZip: json["contact_zip"],
        contactWebsite: json["contact_website"],
        contactAddress: json["contact_address"],
        status: json["status"],
        logo: json["logo"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        jobExperience: json["job_experience"] == null ? null : JobExperience.fromJson(json["job_experience"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "job_title": jobTitle,
        "slug": slug,
        "job_type": jobType?.toJson(),
        "job_category": jobCategory,
        "description": description,
        "no_of_workers": noOfWorkers,
        "license_required": licenseRequired,
        "experience": experience,
        "qualification_required": qualificationRequired,
        "location": location,
        "pay_type_required": payTypeRequired,
        "price_from": priceFrom,
        "price_to": priceTo,
        "employer_question_status": employerQuestionStatus,
        "employer_questions": employerQuestions,
        "company_payment_status": companyPaymentStatus,
        "payment_plan_type": paymentPlanType,
        "payment_plane": paymentPlane,
        "contact_company_name": contactCompanyName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "contact_country": contactCountry,
        "contact_state": contactState,
        "contact_city": contactCity,
        "contact_zip": contactZip,
        "contact_website": contactWebsite,
        "contact_address": contactAddress,
        "status": status,
        "logo": logo,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "job_experience": jobExperience?.toJson(),
    };
}

class JobExperience {
    int? id;
    String? name;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    JobExperience({
        this.id,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory JobExperience.fromJson(Map<String, dynamic> json) => JobExperience(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class JobType {
    int? id;
    String? name;
    String? description;
    dynamic createdAt;
    dynamic updatedAt;
    String? isDefault;

    JobType({
        this.id,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isDefault,
    });

    factory JobType.fromJson(Map<String, dynamic> json) => JobType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_default": isDefault,
    };
}
