import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/model_converter.dart';
import 'package:restaurant_app/widgets/card_item.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (ctx, provider, _) {
        if (provider.state == ResultState.HasData)
          return _buildListFavoritesUI(context, provider);
        else if (provider.state == ResultState.Empty)
          return Center(
            child: CircularProgressIndicator(
              color: darkGreen,
            ),
          );
        else
          return _buildEmptyFavoritesUI(context);
      },
    );
  }

  Widget _buildListFavoritesUI(
      BuildContext context, DatabaseProvider provider) {
    final favorites = provider.favRestaurants;

    return Container(
      child: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (ctx, index) {
          final _item = favorites[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
            child: Dismissible(
              key: ValueKey<String>(_item.id),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                provider.deleteFavorite(_item.id);
                Fluttertoast.showToast(msg: deletedFromFavMessage);
              },
              child: CardItem(
                item: restaurantItemToRestaurantModel(_item),
                onTapCallback: (restaurant) {
                  Navigator.of(context).pushNamed(
                    DetailRestaurantPage.route,
                    arguments: restaurant,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyFavoritesUI(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              LineIcons.boxOpen,
              size: 142.0,
              color: darkGreen.withOpacity(0.4),
            ),
            Text('You have no favorite items yet!',
                style: TextStyle(
                    fontSize: 18.0,
                    color: darkGreen,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
