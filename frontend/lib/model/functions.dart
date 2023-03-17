import 'package:intl/intl.dart';

class Fun {
  static String myDateFormat(DateTime? dateTime) {
    DateTime date = dateTime ?? DateTime(1900), now = DateTime.now();
    String format = "";

    if(now.difference(date).inDays == 0) {
      format = DateFormat('hh:mm a').format(date);
    } else if((now.difference(date).inDays == -1)) {
      format = "Yesterday ${DateFormat('hh:mm a').format(date)}";
    } else {
      format = DateFormat('dd-MM-yyyy hh:mm a').format(date);
    }

    return format;
  }
}
