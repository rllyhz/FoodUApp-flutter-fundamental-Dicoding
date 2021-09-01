import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/response/restaurant_result.dart';

void main() {
  group('API Service testing', () {
    final indexForTesting = 0;
    ApiService apiService;

    test(
        'check if the process of parsing json data from the fetched data completely succeed',
        () async {
      apiService = ApiService();
      var results = await apiService.fetchRestaurants();
      var restaurant = results.restaurants[indexForTesting];

      var parsedData = Restaurant.fromJson(restaurant.toJson());

      expect(parsedData.id, restaurant.id);
      expect(parsedData.name, restaurant.name);
      expect(parsedData.description, restaurant.description);
    });

    test('make sure data that is fetched contains more than one item',
        () async {
      apiService = ApiService();
      var results = await apiService.fetchRestaurants();

      var restaurants = results.restaurants;

      expect(restaurants.isNotEmpty, true);
    });
  });
}
