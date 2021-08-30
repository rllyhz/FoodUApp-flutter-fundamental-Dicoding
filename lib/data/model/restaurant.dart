import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant_menu.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';

import 'menu_item.dart';

class RestaurantModel {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late String? address;
  late RestaurantMenu? menus;
  late List<MenuItem>? categories;
  late List<RestaurantReview>? reviews;

  RestaurantModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.address,
      required this.menus,
      required this.categories,
      required this.reviews});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        address: json['address'],
        menus: RestaurantMenu.fromJson(json["menus"]),
        categories: List<MenuItem>.from(json['categories']).toList(),
        reviews: List<RestaurantReview>.from(
            json["customerReviews"].map((x) => RestaurantReview.fromJson(x))),
      );
}

List<RestaurantModel> parseRestaurantData(String? json) {
  if (json == null || json.isEmpty) {
    return [];
  }

  final Map<String, dynamic> parsedData = jsonDecode(json);
  return parsedData["restaurants"]
      .map<RestaurantModel>((json) => RestaurantModel.fromJson(json))
      .toList();
}
