import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerRow extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onDatePickerPressed;
  final DateFormat formater;

  const DatePickerRow({
    super.key,
    required this.selectedDate,
    required this.onDatePickerPressed,
    required this.formater,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'No date selected'
              : formater.format(selectedDate!),
        ),
        IconButton(
          onPressed: onDatePickerPressed,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
