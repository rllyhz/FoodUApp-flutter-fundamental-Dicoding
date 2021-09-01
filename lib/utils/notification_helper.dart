import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/response/restaurant_result.dart';
import 'package:restaurant_app/utils/generator.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        if (payload != null) {
          selectNotificationSubject.add(payload);
        }
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantsResult restaurantsResult,
  ) async {
    var _channelId = "1010";
    var _channelName = "channel_0101";
    var _channelDescription = "Restaurant App";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Today's Recommended Restaurant</b>";

    if (!restaurantsResult.error && restaurantsResult.restaurants.isNotEmpty) {
      var restaurants = restaurantsResult.restaurants;
      var randomIndex = generateRandomNumber(0, restaurants.length - 1);
      var randomRestaurant = restaurants[randomIndex];

      var restaurantName = randomRestaurant.name;

      await flutterLocalNotificationsPlugin.show(
        randomIndex,
        titleNotification,
        restaurantName,
        platformChannelSpecifics,
        payload: jsonEncode(randomRestaurant.toJson()),
      );
    }
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var randomRestaurant = Restaurant.fromJson(jsonDecode(payload));

      Navigator.pushNamed(
        context,
        route,
        arguments: randomRestaurant,
      );
    });
  }
}
