import 'package:intl/intl.dart';
class Formatter {
  static String dateTime(DateTime dateTime) {
    final formatter = DateFormat('dd-MM-yyyy', 'vi_VN');
    return formatter.format(dateTime);
  }

  static String hour(DateTime? dateTime) {
    final formatter = DateFormat.Hm();
    String hour;
    if (dateTime == null) {
      hour = formatter.format(DateTime.now());
    } else {
      hour = formatter.format(dateTime);
    }
    return hour;
  }
  static double? hourD(DateTime? dateTime) {
    final formatter = DateFormat.H();
    double? hour;
    if (dateTime == null) {
      hour = double.tryParse(formatter.format(DateTime.now()));
    } else {
      hour =  double.tryParse(formatter.format(dateTime));
    }
    return hour;
  }
}