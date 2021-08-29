import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/pages/splashscreen.dart';

getRoutes() => {
      SplashScreen.route: (context) => SplashScreen(),
      MainPage.route: (context) => MainPage(title: "Restaurant"),
      DetailRestaurantPage.route: (context) => DetailRestaurantPage(),
    };
