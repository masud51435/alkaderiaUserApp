// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
    final List<Datum>? data;

    MenuModel({
        this.data,
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final int? id;
    final String? name;
    final String? slug;
    final List<Item>? items;

    Datum({
        this.id,
        this.name,
        this.slug,
        this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    final int? id;
    final String? name;
    final String? slug;
    final int? itemType;
    final String? flatPrice;
    final int? convertPrice;
    final String? currencyPrice;
    final String? description;
    final String? descriptionAlt;
    final String? caution;
    final String? thumb;
    final String? cover;
    final int? halal;
    final String? discount;
    final String? discountOption;
    final int? discountType;
    final String? flatDiscountedPrice;
    final int? convertDiscountedPrice;
    final String? currencyDiscountedPrice;
    final String? categoryName;
    final int? categoryId;
    final int? categorySort;
    final String? menuSection;

    Item({
        this.id,
        this.name,
        this.slug,
        this.itemType,
        this.flatPrice,
        this.convertPrice,
        this.currencyPrice,
        this.description,
        this.descriptionAlt,
        this.caution,
        this.thumb,
        this.cover,
        this.halal,
        this.discount,
        this.discountOption,
        this.discountType,
        this.flatDiscountedPrice,
        this.convertDiscountedPrice,
        this.currencyDiscountedPrice,
        this.categoryName,
        this.categoryId,
        this.categorySort,
        this.menuSection,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        itemType: json["item_type"],
        flatPrice: json["flat_price"],
        convertPrice: json["convert_price"],
        currencyPrice: json["currency_price"],
        description: json["description"],
        descriptionAlt: json["description_alt"],
        caution: json["caution"],
        thumb: json["thumb"],
        cover: json["cover"],
        halal: json["halal"],
        discount: json["discount"],
        discountOption: json["discount_option"],
        discountType: json["discount_type"],
        flatDiscountedPrice: json["flat_discounted_price"],
        convertDiscountedPrice: json["convert_discounted_price"],
        currencyDiscountedPrice: json["currency_discounted_price"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        categorySort: json["category_sort"],
        menuSection: json["menu_section"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "item_type": itemType,
        "flat_price": flatPrice,
        "convert_price": convertPrice,
        "currency_price": currencyPrice,
        "description": description,
        "description_alt": descriptionAlt,
        "caution": caution,
        "thumb": thumb,
        "cover": cover,
        "halal": halal,
        "discount": discount,
        "discount_option": discountOption,
        "discount_type": discountType,
        "flat_discounted_price": flatDiscountedPrice,
        "convert_discounted_price": convertDiscountedPrice,
        "currency_discounted_price": currencyDiscountedPrice,
        "category_name": categoryName,
        "category_id": categoryId,
        "category_sort": categorySort,
        "menu_section": menuSection,
    };
}
