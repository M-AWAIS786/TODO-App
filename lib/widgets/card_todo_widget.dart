import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_riv_fs_app/providers/services_provider.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';

class CardTodoWidget extends ConsumerWidget {
  const CardTodoWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(todoStreamProvider);
    final theme = Theme.of(context);
    return todoData.when(
      data: (todoData) {
        String categoryname = todoData[getIndex].category;
        Color categoryColor = Colors.green;

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
        return Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? lightGrayCustom
                  : darkgreyTextfieldClr,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 0.4,
                    blurRadius: 2,
                    blurStyle: BlurStyle.solid,
                    offset: const Offset(0, 3)),
              ]),
          child: Row(
            children: [
              Container(
                width: 14,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                            onPressed: () {
                              ref
                                  .read(servicePro)
                                  .deleteTask(todoData[getIndex].docID);
                            },
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: theme.brightness == Brightness.light
                                  ? darkgreyTextfieldClr
                                  : whiteClr,
                            )),
                        title: Text(
                          todoData[getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isdone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        subtitle: Text(
                          todoData[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isdone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: blueClr,
                            checkColor: theme.brightness == Brightness.light
                                ? darkgreyTextfieldClr
                                : whiteClr,
                            shape: const CircleBorder(),
                            value: todoData[getIndex].isdone,
                            onChanged: (value) {
                              // print(value);
                              ref.read(servicePro).updateNewTask(
                                  todoData[getIndex].docID, value);
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Column(
                          children: [
                            Divider(
                              color: theme.brightness == Brightness.light
                                  ? commonDivierClr
                                  : commonDivierClr,
                              thickness: 1.5,
                            ),
                            Row(
                              children: [
                                const Text('Today'),
                                const Gap(12),
                                Text(todoData[getIndex].timeTask),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (object, stackTrace) {
        return Center(
          child: Text(stackTrace.toString()),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
