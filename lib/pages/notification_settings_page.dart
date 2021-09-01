import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/preferences/preference_helper.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsPage extends StatelessWidget {
  static final route = "/notification_settings";

  final String title;

  const NotificationSettingsPage({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(title, style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Notifications',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Enable daily notifications as reminder of recommendation restaurants for you.",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Consumer<PreferencesProvider>(builder: (ctx, provider, _) {
                      return Flexible(
                        flex: 1,
                        child: Switch.adaptive(
                          activeColor: darkGreen,
                          value: provider.shouldDailyRecommendationShow,
                          onChanged: (newValue) {
                            provider.setShouldDailyRecommendationBeNotified(
                                newValue);
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
