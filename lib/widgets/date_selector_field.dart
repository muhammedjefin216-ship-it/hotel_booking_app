// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// class DateSelectorField extends StatelessWidget {
//   final String label;
//   final DateTime? selectedDate;
//   final DateTime firstSelectableDate;
//   final ValueChanged<DateTime> onDateSelected;

//   const DateSelectorField({
//     super.key,
//     required this.label,
//     required this.selectedDate,
//     required this.firstSelectableDate,
//     required this.onDateSelected,
//   });

//   Future<void> _pickDate(BuildContext context) async {
//     final initial = selectedDate != null && !selectedDate!.isBefore(firstSelectableDate)
//         ? selectedDate!
//         : firstSelectableDate;

//     final picked = await showDatePicker(
//       context: context,
//       initialDate: initial,
//       firstDate: firstSelectableDate,
//       lastDate: firstSelectableDate.add(const Duration(days: 365)),
//     );

//     if (picked != null) {
//       onDateSelected(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final formatted = selectedDate != null
//         ? DateFormat('EEE, d MMM yyyy').format(selectedDate!)
//         : 'Select date';

//     return InkWell(
//       onTap: () => _pickDate(context),
//       borderRadius: BorderRadius.circular(10),
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
//         ),
//         child: Text(
//           formatted,
//           style: TextStyle(
//             color: selectedDate != null ? null : Theme.of(context).hintColor,
//           ),
//         ),
//       ),
//     );
//   }
// }


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
    final initial = selectedDate != null &&
            !selectedDate!.isBefore(firstSelectableDate)
        ? selectedDate!
        : firstSelectableDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstSelectableDate,
      lastDate: firstSelectableDate.add(
        const Duration(days: 365),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF173B65),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF172033),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDate = selectedDate != null;

    final formatted = hasDate
        ? DateFormat('EEE, d MMM').format(selectedDate!)
        : 'Select date';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _pickDate(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasDate
                  ? const Color(0xFF173B65)
                  : const Color(0xFFE0E5EB),
              width: hasDate ? 1.3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.035),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B65).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF173B65),
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Color(0xFF7B8494),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatted,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hasDate
                            ? const Color(0xFF172033)
                            : const Color(0xFFA0A8B5),
                        fontSize: 13,
                        fontWeight:
                            hasDate ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
