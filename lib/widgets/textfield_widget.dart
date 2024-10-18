import 'package:flutter/material.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.maxLine,
      required this.controllerValue});

  final String hintText;
  final int maxLine;
  final TextEditingController controllerValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.brightness == Brightness.dark
            ? darkgreyTextfieldClr
            : lightGrayCustom,
      ),
      child: TextField(
        controller: controllerValue,
        maxLines: maxLine,
        cursorColor:
            theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          // filled: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}
