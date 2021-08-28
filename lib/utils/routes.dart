import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/main_page.dart';

getRoutes() => {
      MainPage.route: (context) => MainPage(title: "Restaurant"),
      DetailRestaurantPage.route: (context) => DetailRestaurantPage(),
    };
