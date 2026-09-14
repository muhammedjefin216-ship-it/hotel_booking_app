import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateSelectorField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final DateTime firstSelectableDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelectorField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.firstSelectableDate,
    required this.onDateSelected,
  });

  Future<void> _pickDate(BuildContext context) async {
    final initial = selectedDate != null && !selectedDate!.isBefore(firstSelectableDate)
        ? selectedDate!
        : firstSelectableDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstSelectableDate,
      lastDate: firstSelectableDate.add(const Duration(days: 365)),
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatted = selectedDate != null
        ? DateFormat('EEE, d MMM yyyy').format(selectedDate!)
        : 'Select date';

    return InkWell(
      onTap: () => _pickDate(context),
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
        ),
        child: Text(
          formatted,
          style: TextStyle(
            color: selectedDate != null ? null : Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}
