import 'menu_item.dart';

class RestaurantMenu {
  late List<MenuItem> foods;
  late List<MenuItem> drinks;

  RestaurantMenu({
    required this.foods,
    required this.drinks,
  });

  RestaurantMenu.fromJson(Map<String, dynamic> json) {
    foods = new List<MenuItem>.empty(growable: true);

    json['foods'].forEach((v) {
      foods.add(new MenuItem.fromJson(v));
    });

    drinks = new List<MenuItem>.empty(growable: true);

    json['drinks'].forEach((v) {
      drinks.add(new MenuItem.fromJson(v));
    });
  }
}
