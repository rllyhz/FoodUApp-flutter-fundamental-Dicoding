import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/generator.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferenceHelper preferencesHelper;

  static final alarmId = 123;

  PreferencesProvider({required this.preferencesHelper}) {
    _getShouldDailyRecommendationShow();
    _getUsername();
  }

  int _selectedCardInfoIndex = 0;
  int get seletedCardInfoIndex => _selectedCardInfoIndex;

  bool _shouldDailyRecommendationBeNotified = false;
  bool get shouldDailyRecommendationShow =>
      _shouldDailyRecommendationBeNotified;

  String _username = '';
  String get username => _username;

  TextEditingController inputController = TextEditingController();

  void setSelectedCardInfoIndex(int newIndex) {
    _selectedCardInfoIndex = newIndex;
    notifyListeners();
  }

  void setShouldDailyRecommendationBeNotified(bool shouldBeNotified) async {
    preferencesHelper.setShouldDailyRecommendationBeNotified(shouldBeNotified);
    _shouldDailyRecommendationBeNotified = shouldBeNotified;
    notifyListeners();

    if (shouldBeNotified) {
      await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        alarmId,
        BackgroundService.callback,
        startAt: getDailyNotificationTime(),
        exact: true,
        wakeup: true,
      );

      Fluttertoast.showToast(msg: 'Reminder\'s successfully enabled!');
    } else {
      await AndroidAlarmManager.cancel(alarmId);

      Fluttertoast.showToast(msg: 'Reminder\'s successfully disabled!');
    }
  }

  Future _getShouldDailyRecommendationShow() async {
    _shouldDailyRecommendationBeNotified =
        await preferencesHelper.shouldDailyRecommendationBeNotified;
    notifyListeners();
  }

  void saveUsername() {
    preferencesHelper.setUsername(inputController.text);
    _username = inputController.text;
    inputController.clear();
    notifyListeners();

    Fluttertoast.showToast(msg: 'Username\'s successfully set!');
  }

  Future _getUsername() async {
    _username = await preferencesHelper.username ?? "rllyhz";
    notifyListeners();
  }
}
