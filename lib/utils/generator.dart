import 'dart:math';

import 'package:intl/intl.dart';

String generateGreetingText() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;

  if (currentHour >= 0 && currentHour < 12)
    return "Good Morning";
  else if (currentHour > 12 && currentHour < 16)
    return "Good Afternoon";
  else if (currentHour >= 16 && currentHour < 21)
    return "Good Evening";
  else if (currentHour >= 21 && currentHour < 24)
    return "Good Night";
  else
    return "Good Morning";
}

DateTime getDailyNotificationTime() {
  final now = DateTime.now();
  final dateFormat = DateFormat('y/M/d');
  final expectedTime = "11:00:00";
  final completeFormat = DateFormat('y/M/d H:m:s');
  final todayDate = dateFormat.format(now);
  final todayDateAndTime = "$todayDate $expectedTime";
  var resultToday = completeFormat.parseStrict(todayDateAndTime);
  var formatted = resultToday.add(Duration(days: 1));
  final tomorrowDate = dateFormat.format(formatted);
  final tomorrowDateAndTime = "$tomorrowDate $expectedTime";
  var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

  return now.isAfter(resultToday) ? resultTomorrow : resultToday;
}

int generateRandomNumber(int min, int max) => min + Random().nextInt(max - min);
