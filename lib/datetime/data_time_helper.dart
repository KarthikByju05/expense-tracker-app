// conver DateTime to string

String convertDateTimeToString(DateTime dateTime) {
  // for year
  String year = dateTime.year.toString();

  // for month
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // for day
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //final format [yyyy/mm/dd]
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
