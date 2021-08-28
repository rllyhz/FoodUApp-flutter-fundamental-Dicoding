import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/utils/constants.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
