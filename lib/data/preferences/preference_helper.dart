import 'package:shared_preferences/shared_preferences.dart';

class PrefereceHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const DAILY_RECOMMENDATION_KEY = 'DAILY_RECOMMENDATION_KEY';

  PrefereceHelper({required this.sharedPreferences});

  Future<bool> get shouldDailyRecommendationShow async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_RECOMMENDATION_KEY) ?? false;
  }

  void setShouldDailyRecommendationShow(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_RECOMMENDATION_KEY, value);
  }
}
