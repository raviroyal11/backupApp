// To parse this JSON data, do
//
//     final blogListApiResponseModel = blogListApiResponseModelFromJson(jsonString);

import 'dart:convert';

BlogListApiResponseModel blogListApiResponseModelFromJson(String str) =>
    BlogListApiResponseModel.fromJson(json.decode(str));

String blogListApiResponseModelToJson(BlogListApiResponseModel data) =>
    json.encode(data.toJson());

class BlogListApiResponseModel {
  bool? success;
  List<BlogList>? data;
  String? message;

  BlogListApiResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory BlogListApiResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogListApiResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BlogList>.from(
                json["data"]!.map((x) => BlogList.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class BlogList {
  int? id;
  String? authorName;
  String? title;
  String? category;
  dynamic country;
  String? slug;
  String? content;
  dynamic postedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic thumbnailId;
  String? image;
  String? bannerImage;
  dynamic isDeleted;
  String? isActive;
  ManageBlogCategory? manageBlogCategory;

  BlogList({
    this.id,
    this.authorName,
    this.title,
    this.category,
    this.country,
    this.slug,
    this.content,
    this.postedAt,
    this.createdAt,
    this.updatedAt,
    this.thumbnailId,
    this.image,
    this.bannerImage,
    this.isDeleted,
    this.isActive,
    this.manageBlogCategory,
  });

  factory BlogList.fromJson(Map<String, dynamic> json) => BlogList(
        id: json["id"],
        authorName: json["author_name"],
        title: json["title"],
        category: json["category"],
        country: json["country"],
        slug: json["slug"],
        content: json["content"],
        postedAt: json["posted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        thumbnailId: json["thumbnail_id"],
        image: json["image"],
        bannerImage: json["banner_image"],
        isDeleted: json["is_deleted"],
        isActive: json["is_active"],
        manageBlogCategory: json["manage_blog_category"] == null
            ? null
            : ManageBlogCategory.fromJson(json["manage_blog_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_name": authorName,
        "title": title,
        "category": category,
        "country": country,
        "slug": slug,
        "content": content,
        "posted_at": postedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "thumbnail_id": thumbnailId,
        "image": image,
        "banner_image": bannerImage,
        "is_deleted": isDeleted,
        "is_active": isActive,
        "manage_blog_category": manageBlogCategory?.toJson(),
      };
}

class ManageBlogCategory {
  int? id;
  String? parentId;
  String? title;
  String? slug;
  dynamic description;
  dynamic shortDesc;
  dynamic metaTitle;
  dynamic metaDesc;
  String? image;
  dynamic metaKeyword;
  String? displayOrder;
  String? status;
  dynamic isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  ManageBlogCategory({
    this.id,
    this.parentId,
    this.title,
    this.slug,
    this.description,
    this.shortDesc,
    this.metaTitle,
    this.metaDesc,
    this.image,
    this.metaKeyword,
    this.displayOrder,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ManageBlogCategory.fromJson(Map<String, dynamic> json) =>
      ManageBlogCategory(
        id: json["id"],
        parentId: json["parent_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        shortDesc: json["short_desc"],
        metaTitle: json["meta_title"],
        metaDesc: json["meta_desc"],
        image: json["image"],
        metaKeyword: json["meta_keyword"],
        displayOrder: json["display_order"],
        status: json["status"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "title": title,
        "slug": slug,
        "description": description,
        "short_desc": shortDesc,
        "meta_title": metaTitle,
        "meta_desc": metaDesc,
        "image": image,
        "meta_keyword": metaKeyword,
        "display_order": displayOrder,
        "status": status,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
