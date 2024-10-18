import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_riv_fs_app/ui_settings/themes.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.valueText,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String valueText;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Gap(6),
          InkWell(
            onTap: () => onPressed(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? darkgreyTextfieldClr
                    : lightGrayCustom,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(icon),
                  const Gap(4),
                  Text(valueText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
