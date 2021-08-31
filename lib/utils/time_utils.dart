DateTime convertStringDateToDateTime(String date) {
  var stringArray = date.split(" ");

  final _day = stringArray[0];
  final _month = stringArray[1];
  final _year = stringArray[2];

  return DateTime(
    int.parse(_year),
    _stringMonthToIntMonth(_month),
    int.parse(_day),
  );
}

int _stringMonthToIntMonth(String month) {
  if (month.toLowerCase() == 'januari')
    return 0;
  else if (month.toLowerCase() == 'februari')
    return 1;
  else if (month.toLowerCase() == 'maret')
    return 2;
  else if (month.toLowerCase() == 'april')
    return 3;
  else if (month.toLowerCase() == 'mei')
    return 4;
  else if (month.toLowerCase() == 'juni')
    return 5;
  else if (month.toLowerCase() == 'juli')
    return 6;
  else if (month.toLowerCase() == 'agustus')
    return 7;
  else if (month.toLowerCase() == 'september')
    return 8;
  else if (month.toLowerCase() == 'oktober')
    return 9;
  else if (month.toLowerCase() == 'november')
    return 10;
  else if (month.toLowerCase() == 'desember')
    return 11;
  else
    return 0;
}
