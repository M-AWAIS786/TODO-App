import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/providers/pending_notification_provider.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';

class PendingNotifyWidget extends ConsumerWidget {
  const PendingNotifyWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingNotify = ref.watch(pendingNotifyProvider);
// Fetch notifications when the screen is built
    ref.read(pendingNotifyProvider.notifier).fetchnotificationpending();
    final pendyData = pendingNotify[index];
    final categoryname = pendingNotify[index].payload;
    int avaterindex = index + 1;
    final theme = Theme.of(context);

    Color categoryColor = blueClr;
    switch (categoryname) {
      case 'Learning':
        categoryColor = Colors.green;
        break;
      case 'Working':
        categoryColor = Colors.blue;
        break;
      case 'General':
        categoryColor = Colors.orange;
        break;
      default:
    }
    return Card(
      color: theme.brightness == Brightness.light
          ? lightGrayCustom
          : darkgreyTextfieldClr,
      child: ListTile(
        title: Text(pendyData.title.toString()),
        subtitle: Row(
          children: [
            Text(
              pendyData.body.toString(),
              maxLines: 2,
            ),
            // Text(pendyData.payload.toString()),
            Text(pendyData.id.toString()),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: categoryColor,
          child: Text(
            avaterindex.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                ref
                    .read(pendingNotifyProvider.notifier)
                    .completedNotification(pendyData.id, ref);
              },
              icon: const Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                ref
                    .read(pendingNotifyProvider.notifier)
                    .clearnotificationpending(pendyData.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
