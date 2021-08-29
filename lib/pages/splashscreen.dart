import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  static final String route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(MainPage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: SvgPicture.asset(
                'assets/pizza_logo.svg',
                color: darkGreen,
              ),
            ),
            Text('Restaurant App',
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}
