import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/custom_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  static const route = "/home";
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onTabCallback: (index) {
          print("clicked $index");
        },
      ),
      body: Center(
        child: Text("Scratch"),
      ),
    );
  }
}
