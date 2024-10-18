import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateProvider = StateProvider<String>((ref) {
  return 'dd/mm/yyyy';
});

final timeProvider = StateProvider<String>((ref) {
  return 'hh:mm';
});
// ! Wednesday, 11 May
final currentdateProvider = StateProvider<String>((ref) {
  return DateFormat("EEEE,dd MMM").format(DateTime.now());
});
