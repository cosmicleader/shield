import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dart:convert';

part 'guides_model.g.dart';

TrendingCampaignModel trendingCampaignModelFromJson(String str) =>
    TrendingCampaignModel.fromJson(json.decode(str));

String trendingCampaignModelToJson(TrendingCampaignModel data) =>
    json.encode(data.toJson());

class TrendingCampaignModel {
  List<Guides> lists;

  TrendingCampaignModel({
    required this.lists,
  });

  factory TrendingCampaignModel.fromJson(Map<String, dynamic> json) =>
      TrendingCampaignModel(
        lists: List<Guides>.from(json["lists"].map((x) => Guides.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
      };
}

@JsonSerializable()
@HiveType(typeId: 0)
class Guides {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<GuideStep> elements;

  Guides({
    required this.id,
    required this.name,
    required this.elements,
  });

  factory Guides.fromJson(Map<String, dynamic> json) => Guides(
        id: json["id"],
        name: json["name"],
        elements: List<GuideStep>.from(
            json["elements"].map((x) => GuideStep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
      };
}

@JsonSerializable()
@HiveType(typeId: 1)
class GuideStep {
  @HiveField(0)
  int step;
  @HiveField(1)
  String imageUrl;
  @HiveField(2)
  String description;

  GuideStep({
    required this.step,
    required this.imageUrl,
    required this.description,
  });

  factory GuideStep.fromJson(Map<String, dynamic> json) => GuideStep(
        step: json["step"],
        imageUrl: json["imageURL"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "step": step,
        "imageURL": imageUrl,
        "description": description,
      };
}





















// @JsonSerializable()
// @HiveType(typeId: 0)
// class ListElement {
//   final int step;
//   final String imageURL;
//   final String description;

//   ListElement(this.step, this.imageURL, this.description);

//   // factory ListElement.fromJson(Map<String, dynamic> json) =>
//   //     _$ListElementFromJson(json);
//   factory ListElement.fromJson(Map<String, dynamic> json) => 
  
//   // ListElement(
//   //       step: json["step"],
//   //       imageUrl: json["imageURL"],
//   //       description: json["description"],
//   //     );

//   Map<String, dynamic> toJson() => {
//         "step": step,
//         "imageURL": imageUrl,
//         "description": description,
//       };
// }

// @JsonSerializable()
// @HiveType(typeId: 1)
// class ListData {
//   final String id;
//   final String name;
//   final List<ListElement> elements;

//   ListData(this.id, this.name, this.elements);

//   // factory ListData.fromJson(Map<String, dynamic> json) =>
//   //     _$ListDataFromJson(json);

//   // Map<String, dynamic> toJson() => _$ListDataToJson(this);
//   factory ListData.fromJson(Map<String, dynamic> json) => ListData(
//         id: json["id"],
//         name: json["name"],
//         elements: List<ListElement>.from(
//             json["elements"].map((x) => ListElement.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "elements": List<dynamic>.from(ListElement.map((x) => x.toJson())),
//       };

//   Map<String, dynamic> toJson() => _$ListElementToJson(this);
// }
