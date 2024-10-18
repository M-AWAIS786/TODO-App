import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/notifications/notifications.dart';
import 'package:todo_riv_fs_app/providers/completed_notification_provider.dart';

final pendingNotifyProvider =
    StateNotifierProvider<PendingNotifier, List<PendingNotificationRequest>>(
        (ref) {
  return PendingNotifier();
});

class PendingNotifier extends StateNotifier<List<PendingNotificationRequest>> {
  PendingNotifier() : super([]);

  Future<void> fetchnotificationpending() async {
    final pendingnotifcation =
        await NotificationService.getPendingNotificationRequest();
    state = pendingnotifcation;
  }

  Future<void> completedNotification(int id, WidgetRef ref) async {
    final notification = state.firstWhere((notif) => notif.id == id);

    // remove from pending list
    state = state.where((notif) => notif.id != id).toList();

    // add to completed list
    ref
        .read(completedNotifyProvider.notifier)
        .addCompletedNotifcation(notification);
    // Refresh the pending list after completion
    await fetchnotificationpending();
  }

  Future<void> clearnotificationpending(int id) async {
    await NotificationService.cancelPendingNotificationRequest(id);
    fetchnotificationpending();
  }
}
