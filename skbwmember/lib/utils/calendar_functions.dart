String monthNameFromInt(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}

String time24to12(int hour, int minute) {
  String period = hour >= 12 ? 'PM' : 'AM';
  int displayHour = hour > 12 ? hour - 12 : hour;
  return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
}