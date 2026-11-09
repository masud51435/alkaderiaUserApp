// To parse this JSON data, do
//
//     final homeResponseData = homeResponseDataFromJson(jsonString);

import 'dart:convert';

HomeResponseData homeResponseDataFromJson(String str) => HomeResponseData.fromJson(json.decode(str));

String homeResponseDataToJson(HomeResponseData data) => json.encode(data.toJson());

class HomeResponseData {
    final Data? data;

    HomeResponseData({
        this.data,
    });

    factory HomeResponseData.fromJson(Map<String, dynamic> json) => HomeResponseData(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    final int? schemaVersion;
    final List<Section>? sections;

    Data({
        this.schemaVersion,
        this.sections,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        schemaVersion: json["schema_version"],
        sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "schema_version": schemaVersion,
        "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
    };
}

class Section {
    final String? id;
    final String? title;
    final String? subtitle;
    final String? eyebrow;
    final String? highlight;
    final String? imageUrl;
    final String? imageAlt;
    final List<Action>? actions;
    final Info? info;
    final int? position;
    final bool? enabled;
    final List<Card>? cards;
    final List<String>? tabs;
    final List<Restaurant>? restaurants;
    final int? restaurantId;
    final String? defaultFilter;
    final List<Filter>? filters;
    final List<Item>? items;
    final List<String>? paragraphs;
    final Action? action;
    final String? description;
    final String? phone;
    final String? qrImageUrl;
    final String? androidUrl;
    final String? iosUrl;

    Section({
        this.id,
        this.title,
        this.subtitle,
        this.eyebrow,
        this.highlight,
        this.imageUrl,
        this.imageAlt,
        this.actions,
        this.info,
        this.position,
        this.enabled,
        this.cards,
        this.tabs,
        this.restaurants,
        this.restaurantId,
        this.defaultFilter,
        this.filters,
        this.items,
        this.paragraphs,
        this.action,
        this.description,
        this.phone,
        this.qrImageUrl,
        this.androidUrl,
        this.iosUrl,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        eyebrow: json["eyebrow"],
        highlight: json["highlight"],
        imageUrl: json["image_url"],
        imageAlt: json["image_alt"],
        actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        position: json["position"],
        enabled: json["enabled"],
        cards: json["cards"] == null ? [] : List<Card>.from(json["cards"]!.map((x) => Card.fromJson(x))),
        tabs: json["tabs"] == null ? [] : List<String>.from(json["tabs"]!.map((x) => x)),
        restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
        restaurantId: json["restaurant_id"],
        defaultFilter: json["default_filter"],
        filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        paragraphs: json["paragraphs"] == null ? [] : List<String>.from(json["paragraphs"]!.map((x) => x)),
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
        description: json["description"],
        phone: json["phone"],
        qrImageUrl: json["qr_image_url"],
        androidUrl: json["android_url"],
        iosUrl: json["ios_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "eyebrow": eyebrow,
        "highlight": highlight,
        "image_url": imageUrl,
        "image_alt": imageAlt,
        "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
        "info": info?.toJson(),
        "position": position,
        "enabled": enabled,
        "cards": cards == null ? [] : List<dynamic>.from(cards!.map((x) => x.toJson())),
        "tabs": tabs == null ? [] : List<dynamic>.from(tabs!.map((x) => x)),
        "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "restaurant_id": restaurantId,
        "default_filter": defaultFilter,
        "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "paragraphs": paragraphs == null ? [] : List<dynamic>.from(paragraphs!.map((x) => x)),
        "action": action?.toJson(),
        "description": description,
        "phone": phone,
        "qr_image_url": qrImageUrl,
        "android_url": androidUrl,
        "ios_url": iosUrl,
    };
}

class Action {
    final String? type;
    final String? target;
    final String? label;

    Action({
        this.type,
        this.target,
        this.label,
    });

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        type: json["type"],
        target: json["target"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "target": target,
        "label": label,
    };
}

class Card {
    final String? id;
    final String? menuSection;
    final String? title;
    final String? eyebrow;
    final String? description;
    final String? imageUrl;
    final ImageCrop? imageCrop;
    final Action? action;

    Card({
        this.id,
        this.menuSection,
        this.title,
        this.eyebrow,
        this.description,
        this.imageUrl,
        this.imageCrop,
        this.action,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"],
        menuSection: json["menu_section"],
        title: json["title"],
        eyebrow: json["eyebrow"],
        description: json["description"],
        imageUrl: json["image_url"],
        imageCrop: json["image_crop"] == null ? null : ImageCrop.fromJson(json["image_crop"]),
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menu_section": menuSection,
        "title": title,
        "eyebrow": eyebrow,
        "description": description,
        "image_url": imageUrl,
        "image_crop": imageCrop?.toJson(),
        "action": action?.toJson(),
    };
}

class ImageCrop {
    final String? backgroundSize;
    final String? backgroundPosition;

    ImageCrop({
        this.backgroundSize,
        this.backgroundPosition,
    });

    factory ImageCrop.fromJson(Map<String, dynamic> json) => ImageCrop(
        backgroundSize: json["background_size"],
        backgroundPosition: json["background_position"],
    );

    Map<String, dynamic> toJson() => {
        "background_size": backgroundSize,
        "background_position": backgroundPosition,
    };
}

class Filter {
    final String? id;
    final List<int>? itemIds;

    Filter({
        this.id,
        this.itemIds,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        id: json["id"],
        itemIds: json["item_ids"] == null ? [] : List<int>.from(json["item_ids"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "item_ids": itemIds == null ? [] : List<dynamic>.from(itemIds!.map((x) => x)),
    };
}

class Info {
    final String? title;
    final String? text;
    final String? hours;
    final String? hoursText;
    final String? phone;
    final String? phoneText;

    Info({
        this.title,
        this.text,
        this.hours,
        this.hoursText,
        this.phone,
        this.phoneText,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        title: json["title"],
        text: json["text"],
        hours: json["hours"],
        hoursText: json["hours_text"],
        phone: json["phone"],
        phoneText: json["phone_text"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "hours": hours,
        "hours_text": hoursText,
        "phone": phone,
        "phone_text": phoneText,
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

class Restaurant {
    final int? id;
    final String? name;
    final String? slug;
    final List<Item>? items;

    Restaurant({
        this.id,
        this.name,
        this.slug,
        this.items,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
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
