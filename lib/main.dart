import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.pink,
      ),
      initialRoute: MainPage.route,
      routes: getRoutes(),
    );
  }
}
