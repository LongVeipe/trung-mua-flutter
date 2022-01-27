
// yyyy-MM-dd'T'HH:mm:ss.SSS'Z'

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String dateTimeConvertString(
    {required DateTime dateTime, required String dateType}) {
  var local = initializeDateFormatting("vi_VN");
  return DateFormat(dateType, "vi_VN").format(dateTime);
}