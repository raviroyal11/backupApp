// // To parse this JSON data, do
// //
// //     final jobApplyListApiResponseModel = jobApplyListApiResponseModelFromJson(jsonString);

// import 'dart:convert';

// JobApplyListApiResponseModel jobApplyListApiResponseModelFromJson(String str) => JobApplyListApiResponseModel.fromJson(json.decode(str));

// String jobApplyListApiResponseModelToJson(JobApplyListApiResponseModel data) => json.encode(data.toJson());

// class JobApplyListApiResponseModel {
//     bool? success;
//     String? message;
//     List<ApplyJob>? data;

//     JobApplyListApiResponseModel({
//         this.success,
//         this.message,
//         this.data,
//     });

//     factory JobApplyListApiResponseModel.fromJson(Map<String, dynamic> json) => JobApplyListApiResponseModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? [] : List<ApplyJob>.from(json["data"]!.map((x) => ApplyJob.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class ApplyJob {
//     int? id;
//     int? userId;
//     String? jobTitle;
//     String? slug;
//     JobType? jobType;
//     int? jobCategory;
//     String? description;
//     String? noOfWorkers;
//     int? licenseRequired;
//     int? experience;
//     int? qualificationRequired;
//     int? location;
//     String? payTypeRequired;
//     String? priceFrom;
//     String? priceTo;
//     String? employerQuestionStatus;
//     String? employerQuestions;
//     String? companyPaymentStatus;
//     String? paymentPlanType;
//     String? paymentPlane;
//     String? contactCompanyName;
//     String? contactEmail;
//     String? contactPhone;
//     int? contactCountry;
//     int? contactState;
//     int? contactCity;
//     String? contactZip;
//     String? contactWebsite;
//     String? contactAddress;
//     int? status;
//     String? logo;
//     dynamic deletedAt;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? jobStageId;
//     int? applicationStatus;
//     DateTime? appliedAt;
//     String? applicationStatusLabel;
//     String? applicationStatusColor;
//     String? stageLabel;
//     String? stageColor;
//     String? appliedDate;
//     JobExperience? jobExperience;

//     ApplyJob({
//         this.id,
//         this.userId,
//         this.jobTitle,
//         this.slug,
//         this.jobType,
//         this.jobCategory,
//         this.description,
//         this.noOfWorkers,
//         this.licenseRequired,
//         this.experience,
//         this.qualificationRequired,
//         this.location,
//         this.payTypeRequired,
//         this.priceFrom,
//         this.priceTo,
//         this.employerQuestionStatus,
//         this.employerQuestions,
//         this.companyPaymentStatus,
//         this.paymentPlanType,
//         this.paymentPlane,
//         this.contactCompanyName,
//         this.contactEmail,
//         this.contactPhone,
//         this.contactCountry,
//         this.contactState,
//         this.contactCity,
//         this.contactZip,
//         this.contactWebsite,
//         this.contactAddress,
//         this.status,
//         this.logo,
//         this.deletedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.jobStageId,
//         this.applicationStatus,
//         this.appliedAt,
//         this.applicationStatusLabel,
//         this.applicationStatusColor,
//         this.stageLabel,
//         this.stageColor,
//         this.appliedDate,
//         this.jobExperience,
//     });

//     factory ApplyJob.fromJson(Map<String, dynamic> json) => ApplyJob(
//         id: json["id"],
//         userId: json["user_id"] is int ? json["user_id"] : int.tryParse(json["user_id"].toString()),
//         jobTitle: json["job_title"],
//         slug: json["slug"],
//         jobType: json["job_type"] == null ? null : JobType.fromJson(json["job_type"]),
//         jobCategory: json["job_category"],
//         description: json["description"],
//         noOfWorkers: json["no_of_workers"],
//         licenseRequired: json["license_required"],
//         experience: json["experience"],
//         qualificationRequired: json["qualification_required"],
//         location: json["location"],
//         payTypeRequired: json["pay_type_required"],
//         priceFrom: json["price_from"],
//         priceTo: json["price_to"],
//         employerQuestionStatus: json["employer_question_status"],
//         employerQuestions: json["employer_questions"],
//         companyPaymentStatus: json["company_payment_status"],
//         paymentPlanType: json["payment_plan_type"],
//         paymentPlane: json["payment_plane"],
//         contactCompanyName: json["contact_company_name"],
//         contactEmail: json["contact_email"],
//         contactPhone: json["contact_phone"],
//         contactCountry: json["contact_country"],
//         contactState: json["contact_state"],
//         contactCity: json["contact_city"],
//         contactZip: json["contact_zip"],
//         contactWebsite: json["contact_website"],
//         contactAddress: json["contact_address"],
//         status: json["status"],
//         logo: json["logo"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         jobStageId: json["job_stage_id"],
//         applicationStatus: json["application_status"],
//         appliedAt: json["applied_at"] == null ? null : DateTime.parse(json["applied_at"]),
//         applicationStatusLabel: json["application_status_label"],
//         applicationStatusColor: json["application_status_color"],
//         stageLabel: json["stage_label"],
//         stageColor: json["stage_color"],
//         appliedDate: json["applied_date"],
//         jobExperience: json["job_experience"] == null ? null : JobExperience.fromJson(json["job_experience"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "job_title": jobTitle,
//         "slug": slug,
//         "job_type": jobType?.toJson(),
//         "job_category": jobCategory,
//         "description": description,
//         "no_of_workers": noOfWorkers,
//         "license_required": licenseRequired,
//         "experience": experience,
//         "qualification_required": qualificationRequired,
//         "location": location,
//         "pay_type_required": payTypeRequired,
//         "price_from": priceFrom,
//         "price_to": priceTo,
//         "employer_question_status": employerQuestionStatus,
//         "employer_questions": employerQuestions,
//         "company_payment_status": companyPaymentStatus,
//         "payment_plan_type": paymentPlanType,
//         "payment_plane": paymentPlane,
//         "contact_company_name": contactCompanyName,
//         "contact_email": contactEmail,
//         "contact_phone": contactPhone,
//         "contact_country": contactCountry,
//         "contact_state": contactState,
//         "contact_city": contactCity,
//         "contact_zip": contactZip,
//         "contact_website": contactWebsite,
//         "contact_address": contactAddress,
//         "status": status,
//         "logo": logo,
//         "deleted_at": deletedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "job_stage_id": jobStageId,
//         "application_status": applicationStatus,
//         "applied_at": appliedAt?.toIso8601String(),
//         "application_status_label": applicationStatusLabel,
//         "application_status_color": applicationStatusColor,
//         "stage_label": stageLabel,
//         "stage_color": stageColor,
//         "applied_date": appliedDate,
//         "job_experience": jobExperience?.toJson(),
//     };
// }

// class JobExperience {
//     int? id;
//     String? name;
//     int? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     JobExperience({
//         this.id,
//         this.name,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory JobExperience.fromJson(Map<String, dynamic> json) => JobExperience(
//         id: json["id"],
//         name: json["name"],
//         status: json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }

// class JobType {
//     int? id;
//     String? name;
//     String? description;
//     dynamic createdAt;
//     dynamic updatedAt;
//     bool? isDefault;

//     JobType({
//         this.id,
//         this.name,
//         this.description,
//         this.createdAt,
//         this.updatedAt,
//         this.isDefault,
//     });

//     factory JobType.fromJson(Map<String, dynamic> json) => JobType(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         isDefault: json["is_default"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "is_default": isDefault,
//     };
// }

// To parse this JSON data, do
//
//     final jobApplyListApiResponseModel = jobApplyListApiResponseModelFromJson(jsonString);

import 'dart:convert';

JobApplyListApiResponseModel jobApplyListApiResponseModelFromJson(String str) => JobApplyListApiResponseModel.fromJson(json.decode(str));

String jobApplyListApiResponseModelToJson(JobApplyListApiResponseModel data) => json.encode(data.toJson());

class JobApplyListApiResponseModel {
    bool? success;
    String? message;
    List<ApplyJob>? data;

    JobApplyListApiResponseModel({
        this.success,
        this.message,
        this.data,
    });

    factory JobApplyListApiResponseModel.fromJson(Map<String, dynamic> json) => JobApplyListApiResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ApplyJob>.from(json["data"]!.map((x) => ApplyJob.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ApplyJob {
    int? id;
    String? userId;
    String? jobTitle;
    String? slug;
    dynamic employmentType;
    JobType? jobType;
    dynamic jobTypeOther;
    String? jobCategory;
    dynamic jobCategoryOther;
    String? description;
    String? noOfWorkers;
    String? licenseRequired;
    dynamic licenseRequiredOther;
    String? experience;
    String? qualificationRequired;
    dynamic qualificationRequiredOther;
    String? location;
    dynamic payCategoryRequired;
    String? payTypeRequired;
    dynamic payTypeRequiredOther;
    String? priceFrom;
    String? priceTo;
    String? employerQuestionStatus;
    String? employerQuestions;
    String? employerContactStatus;
    String? contactCompanyName;
    String? contactEmail;
    String? contactPhone;
    String? contactCountry;
    String? contactState;
    String? contactCity;
    String? contactZip;
    String? contactWebsite;
    String? contactAddress;
    String? companyPaymentStatus;
    String? paymentPlanType;
    String? paymentPlane;
    String? status;
    String? logo;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? jobStageId;
    String? applicationStatus;
    DateTime? appliedAt;
    String? applicationStatusLabel;
    String? applicationStatusColor;
    String? stageLabel;
    String? stageColor;
    String? appliedDate;
    JobExperience? jobExperience;

    ApplyJob({
        this.id,
        this.userId,
        this.jobTitle,
        this.slug,
        this.employmentType,
        this.jobType,
        this.jobTypeOther,
        this.jobCategory,
        this.jobCategoryOther,
        this.description,
        this.noOfWorkers,
        this.licenseRequired,
        this.licenseRequiredOther,
        this.experience,
        this.qualificationRequired,
        this.qualificationRequiredOther,
        this.location,
        this.payCategoryRequired,
        this.payTypeRequired,
        this.payTypeRequiredOther,
        this.priceFrom,
        this.priceTo,
        this.employerQuestionStatus,
        this.employerQuestions,
        this.employerContactStatus,
        this.contactCompanyName,
        this.contactEmail,
        this.contactPhone,
        this.contactCountry,
        this.contactState,
        this.contactCity,
        this.contactZip,
        this.contactWebsite,
        this.contactAddress,
        this.companyPaymentStatus,
        this.paymentPlanType,
        this.paymentPlane,
        this.status,
        this.logo,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.jobStageId,
        this.applicationStatus,
        this.appliedAt,
        this.applicationStatusLabel,
        this.applicationStatusColor,
        this.stageLabel,
        this.stageColor,
        this.appliedDate,
        this.jobExperience,
    });

    factory ApplyJob.fromJson(Map<String, dynamic> json) => ApplyJob(
        id: json["id"],
        userId: json["user_id"],
        jobTitle: json["job_title"],
        slug: json["slug"],
        employmentType: json["employment_type"],
        jobType: json["job_type"] == null ? null : JobType.fromJson(json["job_type"]),
        jobTypeOther: json["job_type_other"],
        jobCategory: json["job_category"],
        jobCategoryOther: json["job_category_other"],
        description: json["description"],
        noOfWorkers: json["no_of_workers"],
        licenseRequired: json["license_required"],
        licenseRequiredOther: json["license_required_other"],
        experience: json["experience"],
        qualificationRequired: json["qualification_required"],
        qualificationRequiredOther: json["qualification_required_other"],
        location: json["location"],
        payCategoryRequired: json["pay_category_required"],
        payTypeRequired: json["pay_type_required"],
        payTypeRequiredOther: json["pay_type_required_other"],
        priceFrom: json["price_from"],
        priceTo: json["price_to"],
        employerQuestionStatus: json["employer_question_status"],
        employerQuestions: json["employer_questions"],
        employerContactStatus: json["employer_contact_status"],
        contactCompanyName: json["contact_company_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        contactCountry: json["contact_country"],
        contactState: json["contact_state"],
        contactCity: json["contact_city"],
        contactZip: json["contact_zip"],
        contactWebsite: json["contact_website"],
        contactAddress: json["contact_address"],
        companyPaymentStatus: json["company_payment_status"],
        paymentPlanType: json["payment_plan_type"],
        paymentPlane: json["payment_plane"],
        status: json["status"],
        logo: json["logo"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        jobStageId: json["job_stage_id"],
        applicationStatus: json["application_status"],
        appliedAt: json["applied_at"] == null ? null : DateTime.parse(json["applied_at"]),
        applicationStatusLabel: json["application_status_label"],
        applicationStatusColor: json["application_status_color"],
        stageLabel: json["stage_label"],
        stageColor: json["stage_color"],
        appliedDate: json["applied_date"],
        jobExperience: json["job_experience"] == null ? null : JobExperience.fromJson(json["job_experience"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "job_title": jobTitle,
        "slug": slug,
        "employment_type": employmentType,
        "job_type": jobType?.toJson(),
        "job_type_other": jobTypeOther,
        "job_category": jobCategory,
        "job_category_other": jobCategoryOther,
        "description": description,
        "no_of_workers": noOfWorkers,
        "license_required": licenseRequired,
        "license_required_other": licenseRequiredOther,
        "experience": experience,
        "qualification_required": qualificationRequired,
        "qualification_required_other": qualificationRequiredOther,
        "location": location,
        "pay_category_required": payCategoryRequired,
        "pay_type_required": payTypeRequired,
        "pay_type_required_other": payTypeRequiredOther,
        "price_from": priceFrom,
        "price_to": priceTo,
        "employer_question_status": employerQuestionStatus,
        "employer_questions": employerQuestions,
        "employer_contact_status": employerContactStatus,
        "contact_company_name": contactCompanyName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "contact_country": contactCountry,
        "contact_state": contactState,
        "contact_city": contactCity,
        "contact_zip": contactZip,
        "contact_website": contactWebsite,
        "contact_address": contactAddress,
        "company_payment_status": companyPaymentStatus,
        "payment_plan_type": paymentPlanType,
        "payment_plane": paymentPlane,
        "status": status,
        "logo": logo,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "job_stage_id": jobStageId,
        "application_status": applicationStatus,
        "applied_at": appliedAt?.toIso8601String(),
        "application_status_label": applicationStatusLabel,
        "application_status_color": applicationStatusColor,
        "stage_label": stageLabel,
        "stage_color": stageColor,
        "applied_date": appliedDate,
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
    String? employmentTypeId;
    String? name;
    String? description;
    int? isDefault;
    DateTime? createdAt;
    DateTime? updatedAt;

    JobType({
        this.id,
        this.employmentTypeId,
        this.name,
        this.description,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
    });

    factory JobType.fromJson(Map<String, dynamic> json) => JobType(
        id: json["id"],
        employmentTypeId: json["employment_type_id"],
        name: json["name"],
        description: json["description"],
        isDefault: json["is_default"] is int ? json["is_default"] : int.parse(json["is_default"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employment_type_id": employmentTypeId,
        "name": name,
        "description": description,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

