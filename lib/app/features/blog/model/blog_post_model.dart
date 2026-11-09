// To parse this JSON data, do
//
//     final blogPostModel = blogPostModelFromJson(jsonString);

import 'dart:convert';

BlogPostModel blogPostModelFromJson(String str) =>
    BlogPostModel.fromJson(json.decode(str));

String blogPostModelToJson(BlogPostModel data) => json.encode(data.toJson());

class BlogPostModel {
  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  BlogPostModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) => BlogPostModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  final int? id;
  final String? title;
  final String? slug;
  final String? excerpt;
  final String? category;
  final DateTime? publishedAt;
  final String? imageUrl;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.excerpt,
    this.category,
    this.publishedAt,
    this.imageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    String? img = json["image_url"];
    if (img != null && img.isNotEmpty && !img.startsWith('http')) {
      img = 'https://alkaderia.w3informer.com${img.startsWith('/') ? '' : '/'}$img';
    }
    return Datum(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      excerpt: json["excerpt"],
      category: json["category"],
      publishedAt: json["published_at"] == null
          ? null
          : DateTime.parse(json["published_at"]),
      imageUrl: img,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "excerpt": excerpt,
        "category": category,
        "published_at": publishedAt?.toIso8601String(),
        "image_url": imageUrl,
      };
}

class Link {
  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.page,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        page: json["page"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "page": page,
        "active": active,
      };
}
