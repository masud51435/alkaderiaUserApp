// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  final List<LanguageData>? data;

  LanguageModel({
    this.data,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    data: json["data"] == null ? [] : List<LanguageData>.from(json["data"]!.map((x) => LanguageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LanguageData {
  final int? id;
  final String? name;
  final String? code;
  final int? displayMode;
  final int? status;
  final String? image;

  LanguageData({
    this.id,
    this.name,
    this.code,
    this.displayMode,
    this.status,
    this.image,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) => LanguageData(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    displayMode: json["display_mode"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "display_mode": displayMode,
    "status": status,
    "image": image,
  };
}
