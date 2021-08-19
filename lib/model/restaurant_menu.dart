import 'drink.dart';
import 'food.dart';

class RestaurantMenu {
  late List<Food> foods;
  late List<Drink> drinks;

  RestaurantMenu({
    required this.foods,
    required this.drinks,
  });

  RestaurantMenu.fromJson(Map<String, dynamic> json) {
    foods = new List<Food>.empty(growable: true);

    json['foods'].forEach((v) {
      foods.add(new Food.fromJson(v));
    });

    drinks = new List<Drink>.empty(growable: true);

    json['drinks'].forEach((v) {
      drinks.add(new Drink.fromJson(v));
    });
  }
}
