// To parse this JSON data, do
//
//     final resturantMenuModel = resturantMenuModelFromJson(jsonString);

import 'dart:convert';

ResturantMenuModel resturantMenuModelFromJson(String str) => ResturantMenuModel.fromJson(json.decode(str));

String resturantMenuModelToJson(ResturantMenuModel data) => json.encode(data.toJson());

class ResturantMenuModel {
    final Data? data;

    ResturantMenuModel({
        this.data,
    });

    factory ResturantMenuModel.fromJson(Map<String, dynamic> json) => ResturantMenuModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    final int? schemaVersion;
    final String? experience;
    final String? menuSection;
    final Hero? hero;
    final List<Menu>? menus;
    final String? categoryTitle;
    final String? catalogTitle;
    final String? allItemsLabel;
    final String? searchPlaceholder;
    final String? defaultSort;
    final List<SortOption>? sortOptions;
    final List<Category>? categories;
    final List<Item>? items;
    final int? itemCount;
    final String? emptyTitle;
    final String? emptyDescription;
    final String? noResultsTitle;
    final String? noResultsDescription;
    final String? signoff;
    final AppDownload? appDownload;

    Data({
        this.schemaVersion,
        this.experience,
        this.menuSection,
        this.hero,
        this.menus,
        this.categoryTitle,
        this.catalogTitle,
        this.allItemsLabel,
        this.searchPlaceholder,
        this.defaultSort,
        this.sortOptions,
        this.categories,
        this.items,
        this.itemCount,
        this.emptyTitle,
        this.emptyDescription,
        this.noResultsTitle,
        this.noResultsDescription,
        this.signoff,
        this.appDownload,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        schemaVersion: json["schema_version"],
        experience: json["experience"],
        menuSection: json["menu_section"],
        hero: json["hero"] == null ? null : Hero.fromJson(json["hero"]),
        menus: json["menus"] == null ? [] : List<Menu>.from(json["menus"]!.map((x) => Menu.fromJson(x))),
        categoryTitle: json["category_title"],
        catalogTitle: json["catalog_title"],
        allItemsLabel: json["all_items_label"],
        searchPlaceholder: json["search_placeholder"],
        defaultSort: json["default_sort"],
        sortOptions: json["sort_options"] == null ? [] : List<SortOption>.from(json["sort_options"]!.map((x) => SortOption.fromJson(x))),
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        itemCount: json["item_count"],
        emptyTitle: json["empty_title"],
        emptyDescription: json["empty_description"],
        noResultsTitle: json["no_results_title"],
        noResultsDescription: json["no_results_description"],
        signoff: json["signoff"],
        appDownload: json["app_download"] == null ? null : AppDownload.fromJson(json["app_download"]),
    );

    Map<String, dynamic> toJson() => {
        "schema_version": schemaVersion,
        "experience": experience,
        "menu_section": menuSection,
        "hero": hero?.toJson(),
        "menus": menus == null ? [] : List<dynamic>.from(menus!.map((x) => x.toJson())),
        "category_title": categoryTitle,
        "catalog_title": catalogTitle,
        "all_items_label": allItemsLabel,
        "search_placeholder": searchPlaceholder,
        "default_sort": defaultSort,
        "sort_options": sortOptions == null ? [] : List<dynamic>.from(sortOptions!.map((x) => x.toJson())),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "item_count": itemCount,
        "empty_title": emptyTitle,
        "empty_description": emptyDescription,
        "no_results_title": noResultsTitle,
        "no_results_description": noResultsDescription,
        "signoff": signoff,
        "app_download": appDownload?.toJson(),
    };
}

class AppDownload {
    final String? id;
    final String? title;
    final String? imageUrl;
    final String? qrImageUrl;
    final String? androidUrl;
    final String? iosUrl;
    final int? position;
    final bool? enabled;

    AppDownload({
        this.id,
        this.title,
        this.imageUrl,
        this.qrImageUrl,
        this.androidUrl,
        this.iosUrl,
        this.position,
        this.enabled,
    });

    factory AppDownload.fromJson(Map<String, dynamic> json) => AppDownload(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        qrImageUrl: json["qr_image_url"],
        androidUrl: json["android_url"],
        iosUrl: json["ios_url"],
        position: json["position"],
        enabled: json["enabled"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "qr_image_url": qrImageUrl,
        "android_url": androidUrl,
        "ios_url": iosUrl,
        "position": position,
        "enabled": enabled,
    };
}

class Category {
    final String? name;
    final String? imageUrl;
    final List<int>? itemIds;
    final int? count;

    Category({
        this.name,
        this.imageUrl,
        this.itemIds,
        this.count,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        imageUrl: json["image_url"],
        itemIds: json["item_ids"] == null ? [] : List<int>.from(json["item_ids"]!.map((x) => x)),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "item_ids": itemIds == null ? [] : List<dynamic>.from(itemIds!.map((x) => x)),
        "count": count,
    };
}

class Hero {
    final String? title;
    final String? eyebrow;
    final String? subtitle;
    final String? imageUrl;
    final String? imageAlt;

    Hero({
        this.title,
        this.eyebrow,
        this.subtitle,
        this.imageUrl,
        this.imageAlt,
    });

    factory Hero.fromJson(Map<String, dynamic> json) => Hero(
        title: json["title"],
        eyebrow: json["eyebrow"],
        subtitle: json["subtitle"],
        imageUrl: json["image_url"],
        imageAlt: json["image_alt"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "eyebrow": eyebrow,
        "subtitle": subtitle,
        "image_url": imageUrl,
        "image_alt": imageAlt,
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
    final int? restaurantId;
    final String? restaurantSlug;

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
        this.restaurantId,
        this.restaurantSlug,
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
        restaurantId: json["restaurant_id"],
        restaurantSlug: json["restaurant_slug"],
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
        "restaurant_id": restaurantId,
        "restaurant_slug": restaurantSlug,
    };
}

class Menu {
    final String? id;
    final String? label;
    final String? apiUrl;

    Menu({
        this.id,
        this.label,
        this.apiUrl,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        label: json["label"],
        apiUrl: json["api_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "api_url": apiUrl,
    };
}

class SortOption {
    final String? id;
    final String? label;

    SortOption({
        this.id,
        this.label,
    });

    factory SortOption.fromJson(Map<String, dynamic> json) => SortOption(
        id: json["id"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
    };
}
