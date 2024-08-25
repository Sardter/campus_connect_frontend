import 'package:intl/intl.dart';

class DatePickerController {
  DateTime? date;

  String get stringValue => date == null
      ? ""
      : "${DateFormat("yMd").format(date!)} ${DateFormat("Hm").format(date!)}";

  DatePickerController({this.date});
}
