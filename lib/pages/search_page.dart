import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/provider/search_restaurants_provider.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/model_converter.dart';
import 'package:restaurant_app/widgets/card_error.dart';
import 'package:restaurant_app/widgets/card_item.dart';
import 'package:restaurant_app/widgets/loading_feedback.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  void _searchList(String query, SearchRestaurantsProvider provider) {
    if (query.isEmpty) return provider.setState(ResultState.Empty);
    provider.searchRestaurants(query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Consumer<SearchRestaurantsProvider>(
        builder: (ctx, provider, _) {
          if (provider.state == ResultState.Empty) {
            return _buildSearchableListUI(
              context,
              provider,
              Column(
                children: [
                  SizedBox(height: 12.0),
                  Icon(
                    LineIcons.mapMarked,
                    size: MediaQuery.of(context).size.height / 5.6,
                    color: darkGreen.withOpacity(0.4),
                  ),
                  Text('Explore your favorite restaurants with us.',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 36.6,
                          fontWeight: FontWeight.bold,
                          color: darkGreen),
                      textAlign: TextAlign.center)
                ],
              ),
            );
          } else if (provider.state == ResultState.Loading) {
            return _buildSearchableListUI(
              context,
              provider,
              Container(
                margin: EdgeInsets.only(top: 36.0),
                child: Center(
                  child: LoadingFeedback(
                    fontSize: MediaQuery.of(context).size.height / 36.6,
                    text: "Finding what you're looking for...",
                  ),
                ),
              ),
            );
          } else if (provider.state == ResultState.NoData) {
            return _buildSearchableListUI(
              context,
              provider,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: CardError(
                  fontSize: MediaQuery.of(context).size.height / 38,
                  label: "Opps... Item not found!",
                  description:
                      "Data you're looking for could not be found. \nPlease make sure you type the correct query.",
                ),
              ),
            );
          } else if (provider.state == ResultState.Error) {
            return _buildSearchableListUI(
              context,
              provider,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: CardError(
                  label: cardErrorLabel,
                  description: cardErrorDescription,
                ),
              ),
            );
          }

          return _buildSearchableListUI(
            context,
            provider,
            ListView.builder(
              itemCount: provider.searchResult.restaurants.length,
              itemBuilder: (ctx, index) {
                final _item = restaurantItemToRestaurantModel(
                    provider.searchResult.restaurants[index]);

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: CardItem(
                    item: _item,
                    onTapCallback: (restaurant) {
                      Navigator.of(context).pushNamed(
                          DetailRestaurantPage.route,
                          arguments: _item);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchableListUI(
      BuildContext context, SearchRestaurantsProvider provider, Widget child) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: provider.inputController,
              onChanged: (text) {
                _searchList(text, provider);
              },
              onSubmitted: (text) {},
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: darkGreen,
                    ),
                  ),
                  fillColor: darkGreen,
                  focusColor: darkGreen,
                  hoverColor: darkGreen,
                  suffixIcon: GestureDetector(
                    child: Icon(LineIcons.search, color: darkGreen),
                    onTap: () {
                      _searchList(provider.inputController.text, provider);
                    },
                  ),
                  hintText: 'Search here',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
