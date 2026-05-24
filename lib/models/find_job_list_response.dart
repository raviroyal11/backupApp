// // To parse this JSON data, do
// //
// //     final jobListApiResponseModel = jobListApiResponseModelFromJson(jsonString);

// import 'dart:convert';

// JobListApiResponseModel jobListApiResponseModelFromJson(String str) => JobListApiResponseModel.fromJson(json.decode(str));

// String jobListApiResponseModelToJson(JobListApiResponseModel data) => json.encode(data.toJson());

// class JobListApiResponseModel {
//     bool success;
//     Data data;
//     String message;

//     JobListApiResponseModel({
//         required this.success,
//         required this.data,
//         required this.message,
//     });

//     factory JobListApiResponseModel.fromJson(Map<String, dynamic> json) => JobListApiResponseModel(
//         success: json["success"],
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data.toJson(),
//         "message": message,
//     };
// }

// class Data {
//     List<JobData> data;

//     Data({
//         required this.data,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         data: List<JobData>.from(json["data"].map((x) => JobData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class JobData {
//     int id;
//     String title;
//     String companyName;
//     String category;
//     String jobType;
//     String logo;
//     String vacancy;
//     String priceFrom;
//     String priceTo;
//     String payType;
//     String createdAt;

//     JobData({
//         required this.id,
//         required this.title,
//         required this.companyName,
//         required this.category,
//         required this.jobType,
//         required this.logo,
//         required this.vacancy,
//         required this.priceFrom,
//         required this.priceTo,
//         required this.payType,
//         required this.createdAt,
//     });

//     factory JobData.fromJson(Map<String, dynamic> json) => JobData(
//         id: json["id"],
//         title: json["title"],
//         companyName: json["companyName"],
//         category: json["category"],
//         jobType: json["jobType"],
//         logo: json["logo"],
//         vacancy: json["vacancy"],
//         priceFrom: json["price_from"],
//         priceTo: json["price_to"],
//         payType: json["pay_type"],
//         createdAt: json["created_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "companyName": companyName,
//         "category": category,
//         "jobType": jobType,
//         "logo": logo,
//         "vacancy": vacancy,
//         "price_from": priceFrom,
//         "price_to": priceTo,
//         "pay_type": payType,
//         "created_at": createdAt,
//     };
// }


// To parse this JSON data, do
//
//     final jobListApiResponseModel = jobListApiResponseModelFromJson(jsonString);

// import 'dart:convert';

// JobListApiResponseModel jobListApiResponseModelFromJson(String str) => JobListApiResponseModel.fromJson(json.decode(str));

// String jobListApiResponseModelToJson(JobListApiResponseModel data) => json.encode(data.toJson());

// class JobListApiResponseModel {
//     bool? success;
//     String? message;
//     int? count;
//     List<JobData>? data;

//     JobListApiResponseModel({
//         this.success,
//         this.message,
//         this.count,
//         this.data,
//     });

//     factory JobListApiResponseModel.fromJson(Map<String, dynamic> json) => JobListApiResponseModel(
//         success: json["success"],
//         message: json["message"],
//         count: json["count"],
//         data: json["data"] == null ? [] : List<JobData>.from(json["data"]!.map((x) => JobData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "count": count,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class JobData {
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
//     Job? jobExperience;
//     Category? category;
//     Company? company;
//     JobCountry? jobCountry;
//     Job? jobState;
//     Job? jobCity;

//     JobData({
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
//         this.category,
//         this.company,
//         this.jobCountry,
//         this.jobState,
//         this.jobCity,
//     });

//     factory JobData.fromJson(Map<String, dynamic> json) => JobData(
//         id: json["id"],
//         userId: json["user_id"] is String ? int.tryParse(json["user_id"]) : json["user_id"],
//         jobTitle: json["job_title"],
//         slug: json["slug"],
//         jobType: json["job_type"] == null ? null : JobType.fromJson(json["job_type"]),
//         jobCategory: json["job_category"] is String ? int.tryParse(json["job_category"]) : json["job_category"],
//         description: json["description"],
//         noOfWorkers: json["no_of_workers"],
//         licenseRequired: json["license_required"] is String ? int.tryParse(json["license_required"]) : json["license_required"],
//         experience: json["experience"] is String ? int.tryParse(json["experience"]) : json["experience"],
//         qualificationRequired: json["qualification_required"] is String ? int.tryParse(json["qualification_required"]) : json["qualification_required"],
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
//         jobExperience: json["job_experience"] == null ? null : Job.fromJson(json["job_experience"]),
//         category: json["category"] == null ? null : Category.fromJson(json["category"]),
//         company: json["company"] == null ? null : Company.fromJson(json["company"]),
//         jobCountry: json["job_country"] == null ? null : JobCountry.fromJson(json["job_country"]),
//         jobState: json["job_state"] == null ? null : Job.fromJson(json["job_state"]),
//         jobCity: json["job_city"] == null ? null : Job.fromJson(json["job_city"]),
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
//         "category": category?.toJson(),
//         "company": company?.toJson(),
//         "job_country": jobCountry?.toJson(),
//         "job_state": jobState?.toJson(),
//         "job_city": jobCity?.toJson(),
//     };
// }

// class Category {
//     int? id;
//     int? parentId;
//     String? categoryName;
//     String? categorySlug;
//     dynamic categoryBanner;
//     dynamic categoryIcon;
//     dynamic categoryHeading;
//     String? categoryShortDescription;
//     dynamic categoryDetails;
//     int? showOnHome;
//     int? position;
//     dynamic sequence;
//     dynamic tags;
//     dynamic seoTitle;
//     dynamic seoDescription;
//     dynamic seoKewords;
//     int? status;
//     int? isHomeDisplay;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     dynamic deletedAt;
//     dynamic prioritySequence;

//     Category({
//         this.id,
//         this.parentId,
//         this.categoryName,
//         this.categorySlug,
//         this.categoryBanner,
//         this.categoryIcon,
//         this.categoryHeading,
//         this.categoryShortDescription,
//         this.categoryDetails,
//         this.showOnHome,
//         this.position,
//         this.sequence,
//         this.tags,
//         this.seoTitle,
//         this.seoDescription,
//         this.seoKewords,
//         this.status,
//         this.isHomeDisplay,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.prioritySequence,
//     });

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         parentId: json["parent_id"],
//         categoryName: json["category_name"],
//         categorySlug: json["category_slug"],
//         categoryBanner: json["category_banner"],
//         categoryIcon: json["category_icon"],
//         categoryHeading: json["category_heading"],
//         categoryShortDescription: json["category_short_description"],
//         categoryDetails: json["category_details"],
//         showOnHome: json["show_on_home"],
//         position: json["position"],
//         sequence: json["sequence"],
//         tags: json["tags"],
//         seoTitle: json["seo_title"],
//         seoDescription: json["seo_description"],
//         seoKewords: json["seo_kewords"],
//         status: json["status"],
//         isHomeDisplay: json["is_home_display"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//         prioritySequence: json["priority_sequence"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "parent_id": parentId,
//         "category_name": categoryName,
//         "category_slug": categorySlug,
//         "category_banner": categoryBanner,
//         "category_icon": categoryIcon,
//         "category_heading": categoryHeading,
//         "category_short_description": categoryShortDescription,
//         "category_details": categoryDetails,
//         "show_on_home": showOnHome,
//         "position": position,
//         "sequence": sequence,
//         "tags": tags,
//         "seo_title": seoTitle,
//         "seo_description": seoDescription,
//         "seo_kewords": seoKewords,
//         "status": status,
//         "is_home_display": isHomeDisplay,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "deleted_at": deletedAt,
//         "priority_sequence": prioritySequence,
//     };
// }

// class Company {
//     int? id;
//     String? firstName;
//     dynamic lastName;
//     String? email;
//     String? phone;
//     DateTime? emailVerifiedAt;
//     dynamic dob;
//     dynamic gender;
//     int? countryId;
//     int? stateId;
//     int? cityId;
//     String? pincode;
//     int? isActive;
//     int? isVerified;
//     int? roleId;
//     String? language;
//     int? profileViews;
//     String? themeMode;
//     int? createdByCompany;
//     dynamic loginStatus;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     dynamic facebookUrl;
//     dynamic twitterUrl;
//     dynamic linkedinUrl;
//     dynamic googlePlusUrl;
//     dynamic pinterestUrl;
//     int? isDefault;
//     dynamic stripeId;
//     String? regionCode;
//     String? profileLogo;

//     Company({
//         this.id,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phone,
//         this.emailVerifiedAt,
//         this.dob,
//         this.gender,
//         this.countryId,
//         this.stateId,
//         this.cityId,
//         this.pincode,
//         this.isActive,
//         this.isVerified,
//         this.roleId,
//         this.language,
//         this.profileViews,
//         this.themeMode,
//         this.createdByCompany,
//         this.loginStatus,
//         this.createdAt,
//         this.updatedAt,
//         this.facebookUrl,
//         this.twitterUrl,
//         this.linkedinUrl,
//         this.googlePlusUrl,
//         this.pinterestUrl,
//         this.isDefault,
//         this.stripeId,
//         this.regionCode,
//         this.profileLogo,
//     });

//     factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         phone: json["phone"],
//         emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
//         dob: json["dob"],
//         gender: json["gender"],
//         countryId: json["country_id"],
//         stateId: json["state_id"],
//         cityId: json["city_id"],
//         pincode: json["pincode"],
//         isActive: json["is_active"],
//         isVerified: json["is_verified"],
//         roleId: json["role_id"],
//         language: json["language"],
//         profileViews: json["profile_views"],
//         themeMode: json["theme_mode"],
//         createdByCompany: json["created_by_company"],
//         loginStatus: json["login_status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         facebookUrl: json["facebook_url"],
//         twitterUrl: json["twitter_url"],
//         linkedinUrl: json["linkedin_url"],
//         googlePlusUrl: json["google_plus_url"],
//         pinterestUrl: json["pinterest_url"],
//         isDefault: json["is_default"],
//         stripeId: json["stripe_id"],
//         regionCode: json["region_code"],
//         profileLogo: json["profile_logo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "phone": phone,
//         "email_verified_at": emailVerifiedAt?.toIso8601String(),
//         "dob": dob,
//         "gender": gender,
//         "country_id": countryId,
//         "state_id": stateId,
//         "city_id": cityId,
//         "pincode": pincode,
//         "is_active": isActive,
//         "is_verified": isVerified,
//         "role_id": roleId,
//         "language": language,
//         "profile_views": profileViews,
//         "theme_mode": themeMode,
//         "created_by_company": createdByCompany,
//         "login_status": loginStatus,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "facebook_url": facebookUrl,
//         "twitter_url": twitterUrl,
//         "linkedin_url": linkedinUrl,
//         "google_plus_url": googlePlusUrl,
//         "pinterest_url": pinterestUrl,
//         "is_default": isDefault,
//         "stripe_id": stripeId,
//         "region_code": regionCode,
//         "profile_logo": profileLogo,
//     };
// }

// class Job {
//     int? id;
//     int? stateId;
//     String? name;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? status;
//     int? countryId;

//     Job({
//         this.id,
//         this.stateId,
//         this.name,
//         this.createdAt,
//         this.updatedAt,
//         this.status,
//         this.countryId,
//     });

//     factory Job.fromJson(Map<String, dynamic> json) => Job(
//         id: json["id"],
//         stateId: json["state_id"],
//         name: json["name"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         status: json["status"],
//         countryId: json["country_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "state_id": stateId,
//         "name": name,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "status": status,
//         "country_id": countryId,
//     };
// }

// class JobCountry {
//     int? id;
//     String? name;
//     String? shortCode;
//     String? phoneCode;
//     dynamic createdAt;
//     dynamic updatedAt;

//     JobCountry({
//         this.id,
//         this.name,
//         this.shortCode,
//         this.phoneCode,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory JobCountry.fromJson(Map<String, dynamic> json) => JobCountry(
//         id: json["id"],
//         name: json["name"],
//         shortCode: json["short_code"],
//         phoneCode: json["phone_code"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "short_code": shortCode,
//         "phone_code": phoneCode,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
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
//     final jobListApiResponseModel = jobListApiResponseModelFromJson(jsonString);

import 'dart:convert';

JobListApiResponseModel jobListApiResponseModelFromJson(String str) => JobListApiResponseModel.fromJson(json.decode(str));

String jobListApiResponseModelToJson(JobListApiResponseModel data) => json.encode(data.toJson());

class JobListApiResponseModel {
    bool? success;
    String? message;
    int? count;
    List<JobData>? data;

    JobListApiResponseModel({
        this.success,
        this.message,
        this.count,
        this.data,
    });

    factory JobListApiResponseModel.fromJson(Map<String, dynamic> json) => JobListApiResponseModel(
        success: json["success"],
        message: json["message"],
        count: json["count"],
        data: json["data"] == null ? [] : List<JobData>.from(json["data"]!.map((x) => JobData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class JobData {
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
    Job? jobExperience;
    Category? category;
    Company? company;
    JobCountry? jobCountry;
    Job? jobState;
    Job? jobCity;

    JobData({
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
        this.category,
        this.company,
        this.jobCountry,
        this.jobState,
        this.jobCity,
    });

    factory JobData.fromJson(Map<String, dynamic> json) => JobData(
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
        jobExperience: json["job_experience"] == null ? null : Job.fromJson(json["job_experience"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
        jobCountry: json["job_country"] == null ? null : JobCountry.fromJson(json["job_country"]),
        jobState: json["job_state"] == null ? null : Job.fromJson(json["job_state"]),
        jobCity: json["job_city"] == null ? null : Job.fromJson(json["job_city"]),
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
        "category": category?.toJson(),
        "company": company?.toJson(),
        "job_country": jobCountry?.toJson(),
        "job_state": jobState?.toJson(),
        "job_city": jobCity?.toJson(),
    };
}

class Category {
    int? id;
    String? parentId;
    String? categoryName;
    String? categorySlug;
    dynamic categoryBanner;
    dynamic categoryIcon;
    dynamic categoryHeading;
    String? categoryShortDescription;
    dynamic categoryDetails;
    String? showOnHome;
    String? position;
    dynamic sequence;
    dynamic tags;
    dynamic seoTitle;
    dynamic seoDescription;
    dynamic seoKewords;
    String? status;
    String? isHomeDisplay;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic prioritySequence;

    Category({
        this.id,
        this.parentId,
        this.categoryName,
        this.categorySlug,
        this.categoryBanner,
        this.categoryIcon,
        this.categoryHeading,
        this.categoryShortDescription,
        this.categoryDetails,
        this.showOnHome,
        this.position,
        this.sequence,
        this.tags,
        this.seoTitle,
        this.seoDescription,
        this.seoKewords,
        this.status,
        this.isHomeDisplay,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.prioritySequence,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        categoryName: json["category_name"],
        categorySlug: json["category_slug"],
        categoryBanner: json["category_banner"],
        categoryIcon: json["category_icon"],
        categoryHeading: json["category_heading"],
        categoryShortDescription: json["category_short_description"],
        categoryDetails: json["category_details"],
        showOnHome: json["show_on_home"],
        position: json["position"],
        sequence: json["sequence"],
        tags: json["tags"],
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        seoKewords: json["seo_kewords"],
        status: json["status"],
        isHomeDisplay: json["is_home_display"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        prioritySequence: json["priority_sequence"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "category_name": categoryName,
        "category_slug": categorySlug,
        "category_banner": categoryBanner,
        "category_icon": categoryIcon,
        "category_heading": categoryHeading,
        "category_short_description": categoryShortDescription,
        "category_details": categoryDetails,
        "show_on_home": showOnHome,
        "position": position,
        "sequence": sequence,
        "tags": tags,
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "seo_kewords": seoKewords,
        "status": status,
        "is_home_display": isHomeDisplay,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "priority_sequence": prioritySequence,
    };
}

class Company {
    int? id;
    String? firstName;
    dynamic lastName;
    String? email;
    String? phone;
    DateTime? emailVerifiedAt;
    dynamic dob;
    dynamic gender;
    String? countryId;
    String? stateId;
    String? cityId;
    String? pincode;
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
    dynamic facebookUrl;
    dynamic twitterUrl;
    dynamic linkedinUrl;
    dynamic googlePlusUrl;
    dynamic pinterestUrl;
    String? isDefault;
    dynamic stripeId;
    String? regionCode;
    String? profileLogo;

    Company({
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

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        dob: json["dob"],
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

class Job {
    int? id;
    int? stateId;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? status;
    int? countryId;

    Job({
        this.id,
        this.stateId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.countryId,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        stateId: json["state_id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
        countryId: json["country_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "country_id": countryId,
    };
}

class JobCountry {
    int? id;
    String? name;
    String? shortCode;
    String? phoneCode;
    dynamic createdAt;
    dynamic updatedAt;

    JobCountry({
        this.id,
        this.name,
        this.shortCode,
        this.phoneCode,
        this.createdAt,
        this.updatedAt,
    });

    factory JobCountry.fromJson(Map<String, dynamic> json) => JobCountry(
        id: json["id"],
        name: json["name"],
        shortCode: json["short_code"],
        phoneCode: json["phone_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_code": shortCode,
        "phone_code": phoneCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
        description: json["description"],
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
