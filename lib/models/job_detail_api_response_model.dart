// // // To parse this JSON data, do
// // //
// // //     final jobDetailApiResponseModel = jobDetailApiResponseModelFromJson(jsonString);

// // import 'dart:convert';

// // JobDetailApiResponseModel jobDetailApiResponseModelFromJson(String str) => JobDetailApiResponseModel.fromJson(json.decode(str));

// // String jobDetailApiResponseModelToJson(JobDetailApiResponseModel data) => json.encode(data.toJson());

// // class JobDetailApiResponseModel {
// //     bool? success;
// //     JobDetailApiResponseModelData? data;
// //     String? message;

// //     JobDetailApiResponseModel({
// //         this.success,
// //         this.data,
// //         this.message,
// //     });

// //     factory JobDetailApiResponseModel.fromJson(Map<String, dynamic> json) => JobDetailApiResponseModel(
// //         success: json["success"],
// //         data: json["data"] == null ? null : JobDetailApiResponseModelData.fromJson(json["data"]),
// //         message: json["message"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "success": success,
// //         "data": data?.toJson(),
// //         "message": message,
// //     };
// // }

// // class JobDetailApiResponseModelData {
// //     JobDetailsData? data;

// //     JobDetailApiResponseModelData({
// //         this.data,
// //     });

// //     factory JobDetailApiResponseModelData.fromJson(Map<String, dynamic> json) => JobDetailApiResponseModelData(
// //         data: json["data"] == null ? null : JobDetailsData.fromJson(json["data"]),
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "data": data?.toJson(),
// //     };
// // }

// // class JobDetailsData {
// //     int? id;
// //     String? title;
// //     String? companyName;
// //     String? category;
// //     String? jobType;
// //     String? logo;
// //     String? vacancy;
// //     String? priceFrom;
// //     String? priceTo;
// //     String? payType;
// //     String? experience;
// //     String? qualificationRequired;
// //     String? qualification;
// //     String? licenseRequired;
// //     String? license;
// //     String? location;
// //     String? companyContactStatus;
// //     String? employerQuestionStatus;
// //     String? description;
// //     dynamic address;
// //     dynamic requirments;
// //     dynamic responsabilities;
// //     dynamic skills;
// //     String? employerQuestions;
// //     String? createdAt;

// //     JobDetailsData({
// //         this.id,
// //         this.title,
// //         this.companyName,
// //         this.category,
// //         this.jobType,
// //         this.logo,
// //         this.vacancy,
// //         this.priceFrom,
// //         this.priceTo,
// //         this.payType,
// //         this.experience,
// //         this.qualificationRequired,
// //         this.qualification,
// //         this.licenseRequired,
// //         this.license,
// //         this.location,
// //         this.companyContactStatus,
// //         this.employerQuestionStatus,
// //         this.description,
// //         this.address,
// //         this.requirments,
// //         this.responsabilities,
// //         this.skills,
// //         this.employerQuestions,
// //         this.createdAt,
// //     });

// //     factory JobDetailsData.fromJson(Map<String, dynamic> json) => JobDetailsData(
// //         id: json["id"],
// //         title: json["title"],
// //         companyName: json["companyName"],
// //         category: json["category"],
// //         jobType: json["jobType"],
// //         logo: json["logo"],
// //         vacancy: json["vacancy"],
// //         priceFrom: json["price_from"],
// //         priceTo: json["price_to"],
// //         payType: json["pay_type"],
// //         experience: json["experience"],
// //         qualificationRequired: json["qualification_required"],
// //         qualification: json["qualification"],
// //         licenseRequired: json["license_required"],
// //         license: json["license"],
// //         location: json["location"],
// //         companyContactStatus: json["company_contact_status"],
// //         employerQuestionStatus: json["employer_question_status"],
// //         description: json["description"],
// //         address: json["address"],
// //         requirments: json["requirments"],
// //         responsabilities: json["responsabilities"],
// //         skills: json["skills"],
// //         employerQuestions: json["employer_questions"],
// //         createdAt: json["created_at"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "title": title,
// //         "companyName": companyName,
// //         "category": category,
// //         "jobType": jobType,
// //         "logo": logo,
// //         "vacancy": vacancy,
// //         "price_from": priceFrom,
// //         "price_to": priceTo,
// //         "pay_type": payType,
// //         "experience": experience,
// //         "qualification_required": qualificationRequired,
// //         "qualification": qualification,
// //         "license_required": licenseRequired,
// //         "license": license,
// //         "location": location,
// //         "company_contact_status": companyContactStatus,
// //         "employer_question_status": employerQuestionStatus,
// //         "description": description,
// //         "address": address,
// //         "requirments": requirments,
// //         "responsabilities": responsabilities,
// //         "skills": skills,
// //         "employer_questions": employerQuestions,
// //         "created_at": createdAt,
// //     };
// // }


// // To parse this JSON data, do
// //
// //     final jobDetailApiResponseModel = jobDetailApiResponseModelFromJson(jsonString);

// import 'dart:convert';

// JobDetailApiResponseModel jobDetailApiResponseModelFromJson(String str) => JobDetailApiResponseModel.fromJson(json.decode(str));

// String jobDetailApiResponseModelToJson(JobDetailApiResponseModel data) => json.encode(data.toJson());

// class JobDetailApiResponseModel {
//     bool? success;
//     String? message;
//     JobDetailsData? data;

//     JobDetailApiResponseModel({
//         this.success,
//         this.message,
//         this.data,
//     });

//     factory JobDetailApiResponseModel.fromJson(Map<String, dynamic> json) => JobDetailApiResponseModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : JobDetailsData.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data?.toJson(),
//     };
// }

// class JobDetailsData {
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
//     JobExperience? jobExperience;

//     JobDetailsData({
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
//         this.jobExperience,
//     });

//     factory JobDetailsData.fromJson(Map<String, dynamic> json) => JobDetailsData(
//         id: json["id"],
//         userId: json["user_id"] is int ? json["user_id"] : int.tryParse(json["user_id"].toString()) ?? 0,
//         jobTitle: json["job_title"],
//         slug: json["slug"],
//         jobType: json["job_type"] == null ? null : JobType.fromJson(json["job_type"]),
//         jobCategory: json["job_category"] is int ? json["job_category"] : int.tryParse(json["job_category"].toString()) ?? 0,
//         description: json["description"],
//         noOfWorkers: json["no_of_workers"],
//         licenseRequired: json["license_required"] is int ? json["license_required"] : int.tryParse(json["license_required"].toString()) ?? 0,
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
//         logo: json["logo"] == null ? '' : json["logo"].toString(),
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
//     final jobDetailApiResponseModel = jobDetailApiResponseModelFromJson(jsonString);

import 'dart:convert';

JobDetailApiResponseModel jobDetailApiResponseModelFromJson(String str) => JobDetailApiResponseModel.fromJson(json.decode(str));

String jobDetailApiResponseModelToJson(JobDetailApiResponseModel data) => json.encode(data.toJson());

class JobDetailApiResponseModel {
    bool? success;
    String? message;
    JobDetailsData? data;

    JobDetailApiResponseModel({
        this.success,
        this.message,
        this.data,
    });

    factory JobDetailApiResponseModel.fromJson(Map<String, dynamic> json) => JobDetailApiResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : JobDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class JobDetailsData {
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
    JobExperience? jobExperience;

    JobDetailsData({
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
        this.jobExperience,
    });

    factory JobDetailsData.fromJson(Map<String, dynamic> json) => JobDetailsData(
        id: json["id"],
        userId: json["user_id"],
        jobTitle: json["job_title"],
        slug: json["slug"],
        employmentType: json["employment_type"],
        jobType: json["job_type"] == null ? null : (json["job_type"] is Map<String, dynamic> ? JobType.fromJson(json["job_type"]) : null),
        jobTypeOther: json["job_type_other"],
        jobCategory: json["job_category"],
        jobCategoryOther: json["job_category_other"],
        description: json["description"],
        noOfWorkers: json["no_of_workers"] == null ? '' : json["no_of_workers"].toString(),
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
    String? isDefault;
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
        description: json["description"] ,
        isDefault: json["is_default"],
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
