import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferenceHelper preferencesHelper;

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

  void setShouldDailyRecommendationBeNotified(bool shouldBeNotified) {
    preferencesHelper.setShouldDailyRecommendationBeNotified(shouldBeNotified);
    _shouldDailyRecommendationBeNotified = shouldBeNotified;
    notifyListeners();

    if (shouldBeNotified) {
      Fluttertoast.showToast(msg: 'Reminder\'s successfully enabled!');
    } else {
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
