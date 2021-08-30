import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/response/restaurant_result.dart';

RestaurantModel restaurantItemToRestaurantModel(Restaurant restaurant) =>
    RestaurantModel(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
      address: null,
      menus: null,
      category: null,
      reviews: null,
    );
