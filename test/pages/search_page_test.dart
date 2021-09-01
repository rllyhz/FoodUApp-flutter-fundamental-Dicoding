import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/provider/search_restaurants_provider.dart';
import 'package:restaurant_app/utils/constants.dart';

Widget _createSearchScreen() =>
    ChangeNotifierProvider<SearchRestaurantsProvider>(
      create: (_) => SearchRestaurantsProvider(
        apiService: ApiService(),
      ),
      child: MaterialApp(
        home: Scaffold(
          body: SearchPage(),
        ),
      ),
    );

main() {
  testWidgets('check if icon and its description text show up on Search Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(_createSearchScreen());
    expect(find.byKey(mapMarkedIconKey), findsOneWidget);
    expect(find.byKey(descriptionMapMarkedIconKey), findsOneWidget);
  });
}
