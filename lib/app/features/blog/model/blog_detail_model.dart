// To parse this JSON data, do
//
//     final blogStoryModel = blogStoryModelFromJson(jsonString);

import 'dart:convert';

BlogStoryModel blogStoryModelFromJson(String str) => BlogStoryModel.fromJson(json.decode(str));

String blogStoryModelToJson(BlogStoryModel data) => json.encode(data.toJson());

class BlogStoryModel {
    final Data? data;

    BlogStoryModel({
        this.data,
    });

    factory BlogStoryModel.fromJson(Map<String, dynamic> json) => BlogStoryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    final int? id;
    final String? title;
    final String? slug;
    final String? excerpt;
    final String? body;
    final String? category;
    final bool? isPublished;
    final DateTime? publishedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? imageUrl;

    Data({
        this.id,
        this.title,
        this.slug,
        this.excerpt,
        this.body,
        this.category,
        this.isPublished,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) {
        String? img = json["image_url"];
        if (img != null && img.isNotEmpty && !img.startsWith('http')) {
            img = 'https://alkaderia.w3informer.com${img.startsWith('/') ? '' : '/'}$img';
        }
        return Data(
            id: json["id"],
            title: json["title"],
            slug: json["slug"],
            excerpt: json["excerpt"],
            body: json["body"],
            category: json["category"],
            isPublished: json["is_published"],
            publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
            createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
            updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
            imageUrl: img,
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "excerpt": excerpt,
        "body": body,
        "category": category,
        "is_published": isPublished,
        "published_at": publishedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
    };
}
