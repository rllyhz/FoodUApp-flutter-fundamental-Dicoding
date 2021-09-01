import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const DAILY_RECOMMENDATION_KEY = 'DAILY_RECOMMENDATION_KEY';
  static const USERNAME_KEY = 'USERNAME_KEY';

  PreferenceHelper({required this.sharedPreferences});

  Future<bool> get shouldDailyRecommendationBeNotified async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_RECOMMENDATION_KEY) ?? false;
  }

  void setShouldDailyRecommendationBeNotified(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_RECOMMENDATION_KEY, value);
  }

  Future<String?> get username async {
    final prefs = await sharedPreferences;
    return prefs.getString(USERNAME_KEY);
  }

  void setUsername(String username) async {
    final prefs = await sharedPreferences;
    prefs.setString(USERNAME_KEY, username);
  }
}
