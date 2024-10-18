import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completedNotifyProvider =
    StateNotifierProvider<CompletedNotifier, List<PendingNotificationRequest>>(
        (ref) {
  return CompletedNotifier();
});

class CompletedNotifier
    extends StateNotifier<List<PendingNotificationRequest>> {
  CompletedNotifier() : super([]);

  void addCompletedNotifcation(PendingNotificationRequest notification) {
    state = [...state, notification];
  }

  void removeCompletedNotification(int id) {
    state = state.where((element) => element.id != id).toList();
  }
}
