import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/generator.dart';
import 'package:restaurant_app/utils/model_converter.dart';
import 'package:restaurant_app/widgets/card_error.dart';
import 'package:restaurant_app/widgets/card_item.dart';
import 'package:restaurant_app/widgets/loading_feedback.dart';

import 'detail_restaurant_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
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
            Consumer<RestaurantProvider>(
              builder: (ctx, provider, _) {
                if (provider.state == ResultState.Loading) {
                  return Container(
                    margin: EdgeInsets.only(top: 120.0),
                    child: LoadingFeedback(
                      text: "Preparing recommendation items for you...",
                    ),
                  );
                } else if (provider.state == ResultState.Error) {
                  return CardError(
                    label: cardErrorLabel,
                    description: cardErrorDescription,
                  );
                } else {
                  final restaurants = provider.results.restaurants;
                  return ListView.builder(
                    itemCount: restaurants.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      final item =
                          restaurantItemToRestaurantModel(restaurants[index]);

                      return CardItem(
                        item: item,
                        onTapCallback: (restaurant) {
                          Navigator.of(context).pushNamed(
                              DetailRestaurantPage.route,
                              arguments: restaurant);
                        },
                      );
                    },
                  );
                }
              },
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
