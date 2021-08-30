import 'dart:convert';

import 'package:restaurant_app/data/response/detail_restaurant_result.dart';
import 'package:restaurant_app/data/response/restaurant_result.dart';
import 'package:http/http.dart' as http;

enum ResultState { Loading, HasData, NoData, Error, Empty }

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  static final String pictureMediumSizeBaseUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static final String pictureSmallSizeBaseUrl =
      'https://restaurant-api.dicoding.dev/images/small/';

  Future<RestaurantsResult> fetchRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));

    if (response.statusCode == 200) {
      return restaurantsResultFromJson(response.body);
    } else {
      throw Exception('Failed to fetch restaurants data');
    }
  }

  Future<DetailRestaurantResult> fetchDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/" + id));

    if (response.statusCode == 200) {
      return detailRestaurantResultFromJson(response.body);
    } else {
      throw Exception('Failed to fetch restaurants data');
    }
  }
}