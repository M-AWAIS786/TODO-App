import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_riv_fs_app/model/todo_task_model.dart';
import 'package:todo_riv_fs_app/notifications/notifications.dart';
import 'package:todo_riv_fs_app/providers/date_time_provider.dart';
import 'package:todo_riv_fs_app/providers/notificationId_provider.dart';
import 'package:todo_riv_fs_app/providers/radio_provider.dart';
import 'package:todo_riv_fs_app/providers/services_provider.dart';
import 'package:todo_riv_fs_app/widgets/datetime_widget.dart';
import 'package:todo_riv_fs_app/widgets/radio_widget.dart';
import 'package:todo_riv_fs_app/widgets/textfield_widget.dart';

class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({super.key});

  @override
  AddNewTaskModelState createState() => AddNewTaskModelState();
}

// AddNewTaskModel({super.key});
class AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {
  final titleCont = TextEditingController();
  final descCont = TextEditingController();

  @override
  void dispose() {
    titleCont.dispose();
    descCont.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        // height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        // color:
        //     theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                  textAlign: TextAlign.center,
                  'New Task Todo',
                  style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            const Divider(),
            const Text('Title Task', style: TextStyle(fontSize: 20)),
            TextFieldWidget(
              hintText: 'Add Task Name',
              maxLine: 1,
              controllerValue: titleCont,
            ),
            const Gap(8.0),
            const Text('Description', style: TextStyle(fontSize: 20)),
            TextFieldWidget(
              hintText: 'Add Description',
              maxLine: 5,
              controllerValue: descCont,
            ),
            const Gap(8.0),
            const Text('Category', style: TextStyle(fontSize: 20)),
            Row(
              children: [
                Expanded(
                  child: RadioWidget(
                    inputvalue: 1,
                    titleRadio: 'LRN',
                    categoryColor: Colors.green,
                    onChanged: () {
                      ref.read(radioProvider.notifier).state = 1;
                    },
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    inputvalue: 2,
                    titleRadio: 'WRK',
                    categoryColor: Colors.blue,
                    onChanged: () {
                      ref.read(radioProvider.notifier).state = 2;
                    },
                  ),
                ),
                Expanded(
                  child: RadioWidget(
                    inputvalue: 3,
                    titleRadio: 'GEN',
                    categoryColor: Colors.amberAccent,
                    onChanged: () {
                      ref.read(radioProvider.notifier).state = 3;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  title: 'Date',
                  valueText: dateProv,
                  icon: Icons.calendar_month_outlined,
                  onPressed: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialDate: DateTime.now(),
                    );
                    if (getValue != null) {
                      // ?
                      // ref.read(datenotifcationsProvider.notifier).state =
                      // getValue;
                      final format = DateFormat.yMd().format(getValue);
                      ref.read(dateProvider.notifier).state = format;

                      // print(format);
                    }
                  },
                ),
                const Gap(12),
                DateTimeWidget(
                  title: 'Time',
                  valueText: timeProv,
                  icon: Icons.timer_outlined,
                  onPressed: () async {
                    final getValue = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getValue != null && mounted) {
                      // ignore: use_build_context_synchronously
                      final format = getValue.format(context);
                      ref.read(timeProvider.notifier).state = format;
                    }
                  },
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.brightness == Brightness.light
                          ? Colors.white
                          : Colors.transparent,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final dateVal = ref.read(dateProvider);
                      final timeVal = ref.read(timeProvider);
                      final getRadioValue = ref.read(radioProvider);
                      final notiIdProvider =
                          ref.read(uniqueIDProvider.notifier).getNextId();

                      String category = '';
                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;
                        case 2:
                          category = 'Working';
                          break;
                        case 3:
                          category = 'General';
                          break;
                      }
                      ref.read(servicePro).addNewTask(TodoModel(
                          titleTask: titleCont.text,
                          description: descCont.text,
                          category: category,
                          dateTask: dateVal,
                          timeTask: timeVal,
                          isdone: false));
                      // print('data is saved successful');
                      NotificationService.showInstantNotification(
                          notiIdProvider,
                          titleCont.text,
                          descCont.text,
                          category);

                      DateTime combinedDateTime =
                          datetimeparse(dateVal, timeVal);

                      NotificationService.scheduleNotification(
                          notiIdProvider,
                          titleCont.text,
                          descCont.text,
                          combinedDateTime,
                          category);

                      titleCont.clear();
                      descCont.clear();
                      ref.read(radioProvider.notifier).state = 0;
                      ref.read(dateProvider.notifier).state = 'dd/mm/yyyy';
                      ref.read(timeProvider.notifier).state = 'hh:mm';
                      Navigator.pop(context);
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DateTime datetimeparse(String dateVal, String timeVal) {
    final parsedDate = DateFormat.yMd().parse(dateVal); // Parse the date

    // Extract the time part without AM/PM
    final timeParts = timeVal.split(" ");
    final timeValWithoutAMPM = timeParts[0]; // Get the time part
    final ampm = timeParts.length > 1
        ? timeParts[1]
        : ''; // Get AM or PM part if present

    // Split the time into hour and minute
    final parsedTimeParts = timeValWithoutAMPM.split(":");
    int hour = int.parse(parsedTimeParts[0]);
    final minute = int.parse(parsedTimeParts[1]);

    // Adjust the hour for 24-hour format
    if (ampm == "PM" && hour != 12) {
      hour += 12; // Convert PM hours
    } else if (ampm == "AM" && hour == 12) {
      hour = 0; // Handle midnight case
    }

    // Combine date and time into a DateTime object
    final combinedDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      hour,
      minute,
    );

    log(combinedDateTime.toString(), name: 'combinedDateTime');
    return combinedDateTime;
  }
}
