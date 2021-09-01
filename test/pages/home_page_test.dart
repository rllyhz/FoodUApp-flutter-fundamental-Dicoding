import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/constants.dart';

Widget _createHomeScreen() => ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: MaterialApp(
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('check if welcome texts show up on Home Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(_createHomeScreen());
    expect(find.byKey(greetingText1Key), findsOneWidget);
    expect(find.byKey(greetingText2Key), findsOneWidget);
  });
}
