import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/providers/pending_notification_provider.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';
import 'package:todo_riv_fs_app/widgets/card_pending_notif_widget.dart';
import 'package:todo_riv_fs_app/providers/completed_notification_provider.dart'; // Import your completed provider here

class PendingNotifyScreen extends ConsumerWidget {
  const PendingNotifyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingNotify = ref.watch(pendingNotifyProvider);
    final completedNotify =
        ref.watch(completedNotifyProvider); // Get the completed notifications
    final theme = Theme.of(context);
    // Fetch pending notifications when the screen is built
    ref.read(pendingNotifyProvider.notifier).fetchnotificationpending();

    return DefaultTabController(
      length: 2, // Number of tabs
      animationDuration: const Duration(milliseconds: 800),
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          bottom: TabBar(
            indicatorColor: blueClr,
            labelColor: theme.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pending Notifications
            pendingNotify.isEmpty
                ? const Center(
                    child: Text('No Notifications Pending'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: pendingNotify.length,
                    itemBuilder: (context, index) {
                      return PendingNotifyWidget(index: index);
                    },
                  ),

            // Completed Notifications
            completedNotify.isEmpty
                ? const Center(
                    child: Text('No Notifications Completed'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: completedNotify.length,
                    itemBuilder: (context, index) {
                      final completedNotification = completedNotify[index];
                      return ListTile(
                        title: Text(completedNotification.title.toString()),
                        subtitle: Text(completedNotification.body.toString()),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
