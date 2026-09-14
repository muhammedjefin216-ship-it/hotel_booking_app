// import 'package:flutter/material.dart';


// class GuestFilterRow extends StatelessWidget {
//   static const List<int?> options = [null, 1, 2, 3, 4];

//   final int? selected;
//   final ValueChanged<int?> onChanged;

//   const GuestFilterRow({
//     super.key,
//     required this.selected,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       children: options.map((option) {
//         final label = option == null ? 'Any' : '$option+';
//         final isSelected = option == selected;
//         return ChoiceChip(
//           label: Text(label),
//           selected: isSelected,
//           onSelected: (_) => onChanged(option),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';

class GuestFilterRow extends StatelessWidget {
  static const List<int?> options = [
    null,
    1,
    2,
    3,
    4,
  ];

  final int? selected;
  final ValueChanged<int?> onChanged;

  const GuestFilterRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          final label = option == null ? 'Any' : '$option+';
          final isSelected = option == selected;

          return Padding(
            padding: const EdgeInsets.only(right: 9),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onChanged(option),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF173B65)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF173B65)
                            : const Color(0xFFE0E5EB),
                      ),
                      boxShadow: [
                        if (!isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.025),
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          option == null
                              ? Icons.people_outline_rounded
                              : Icons.person_outline_rounded,
                          size: 17,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF596474),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF596474),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
