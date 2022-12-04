import 'package:intl/intl.dart';

const insertDateHelper = true;

extension DateTimeX on DateTime {
  String get formattedDate => DateFormat('dd/MM/yyyy').format(this);
}
