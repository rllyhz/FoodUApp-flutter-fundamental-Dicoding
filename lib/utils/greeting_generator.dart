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
