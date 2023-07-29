import 'package:friendzone/presentation/routes/path.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Formatter {
  static String timeAgo(String dateTime) {
    final date = DateTime.tryParse(dateTime)!;
    return timeago.format(date);
  }

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
      hour = double.tryParse(formatter.format(dateTime));
    }
    return hour;
  }

  static String emailtoDisplayName(String value) {
    return value.split('@')[0];
  }

  static String nameRoute(String path) {
    return '/${RoutePath.main}/$path';
  }
}
