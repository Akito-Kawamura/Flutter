import 'package:intl/intl.dart';

class Utils {
  static const int secondsInDay = 86400;

  // 次の購入日を計算する関数
  static int calculateNextPurchaseDate(int timing, int updateDate) {
    return updateDate + (timing * secondsInDay);
  }

  // タイムスタンプを日付形式に変換する関数
  static String formatDate(int timestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
