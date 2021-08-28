import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/utils/greeting_generator.dart';
import 'package:restaurant_app/widgets/card_item.dart';
import 'detail_restaurant_page.dart';

class HomePage extends StatelessWidget {
  final List<Restaurant> restaurants;

  const HomePage({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            _buildGreetingUI(context),
            SizedBox(height: 24.0),
            Text("Today's recommendations", style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (ctx, index) {
                  return CardItem(
                    item: restaurants[index],
                    onTapCallback: (restaurant) {
                      Navigator.of(context).pushNamed(
                          DetailRestaurantPage.route,
                          arguments: restaurant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Hi, Rully",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.normal)),
        Text(
          generateGreetingText(),
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
