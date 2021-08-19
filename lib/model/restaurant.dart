import 'dart:convert';
import 'package:restaurant_app/model/restaurant_menu.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late RestaurantMenu menus;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"].toDouble();
    menus = RestaurantMenu.fromJson(json["menus"]);
  }
}

List<Restaurant> parseRestaurantData(String? json) {
  if (json == null || json.isEmpty) {
    return [];
  }

  final Map<String, dynamic> parsedData = jsonDecode(json);
  return parsedData["restaurants"]
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();
}
