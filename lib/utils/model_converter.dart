import 'package:restaurant_app/data/model/menu_item.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_menu.dart';
import 'package:restaurant_app/data/response/detail_restaurant_result.dart'
    as detail_restaurant_result;
import 'package:restaurant_app/data/response/restaurant_result.dart'
    as restaurant_result;

RestaurantModel restaurantItemToRestaurantModel(
        restaurant_result.Restaurant restaurant) =>
    RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
      address: null,
      menus: null,
      categories: null,
      reviews: null,
    );

restaurant_result.Restaurant restaurantModelToRestaurantItem(
        RestaurantModel restaurantModel) =>
    restaurant_result.Restaurant(
      id: restaurantModel.id,
      name: restaurantModel.name,
      description: restaurantModel.description,
      pictureId: restaurantModel.pictureId,
      city: restaurantModel.city,
      rating: restaurantModel.rating,
    );

RestaurantModel detailRestaurantToRestaurantModel(
        detail_restaurant_result.Restaurant restaurant) =>
    RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
      address: restaurant.address,
      menus: RestaurantMenu(
        foods:
            restaurant.menus.foods.map((e) => MenuItem(name: e.name)).toList(),
        drinks:
            restaurant.menus.drinks.map((e) => MenuItem(name: e.name)).toList(),
      ),
      categories:
          restaurant.categories.map((e) => MenuItem(name: e.name)).toList(),
      reviews: restaurant.customerReviews,
    );
