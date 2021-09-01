import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final ReceivePort _port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alartm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().fetchRestaurants();
    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
