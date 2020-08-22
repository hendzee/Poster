import 'package:intl/intl.dart';

class DateFormater {
  // Standard date format like: 10 Jul, 2020
  static String standardDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime).toString();
  }

  // Standard date format to date range
  static String standardDateRange(DateTime stardDate, DateTime endDate) {
    String dateResult;

    if (stardDate == endDate) {
      dateResult = DateFormat('MMM d, yyyy').format(stardDate).toString();
    }else {
      dateResult = DateFormat('MMM d, yyyy').format(stardDate).toString()
          + ' to ' + DateFormat('MMM d, yyyy').format(endDate).toString();
    }

    return dateResult;
  }
}