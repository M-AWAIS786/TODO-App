import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riv_fs_app/providers/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget(
      {super.key,
      required this.inputvalue,
      required this.titleRadio,
      required this.categoryColor,
      required this.onChanged});

  final String titleRadio;
  final Color categoryColor;
  final int inputvalue;
  final VoidCallback onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);

    return Material(
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          activeColor: categoryColor,
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-22, 0),
            child: Text(titleRadio,
                style: TextStyle(
                    color: categoryColor, fontWeight: FontWeight.w700)),
          ),
          value: inputvalue,
          groupValue: radioCategory,
          onChanged: (value) => onChanged(),
        ),
      ),
    );
  }
}
