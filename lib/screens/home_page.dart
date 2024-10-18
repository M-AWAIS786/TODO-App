import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riv_fs_app/providers/date_time_provider.dart';
import 'package:todo_riv_fs_app/providers/services_provider.dart';
import 'package:todo_riv_fs_app/screens/add_newtask_model.dart';
import 'package:todo_riv_fs_app/screens/pending_notify_screen.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';
import 'package:todo_riv_fs_app/widgets/card_todo_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexTododata = ref.watch(todoStreamProvider);
    final theme = Theme.of(context);
    final currentdate = ref.watch(currentdateProvider);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        title: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Image.asset(
              'assets/avater.png',
            ),
          ),
          title: Text(
            'Hello, I\'m',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text('Muhammad Awais',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.calendar_month_rounded)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PendingNotifyScreen(),
                    ));
              },
              icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Task',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // Wednesday, 11 May
                    Text(currentdate),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                    // backgroundColor: Colors.white,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const AddNewTaskModel(),
                  ),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 4, 92, 255),
                      backgroundColor: theme.brightness == Brightness.light
                          ? lightGrayCustom
                          : blueClr,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('+ New Task',
                      style: TextStyle(
                          fontSize: 18,
                          color: theme.brightness == Brightness.dark
                              ? whiteClr
                              : blueClr)),
                ),
              ],
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: indexTododata.value?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CardTodoWidget(
                      getIndex: index,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
