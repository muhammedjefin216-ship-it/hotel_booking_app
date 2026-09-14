import 'package:flutter/material.dart';


class GuestFilterRow extends StatelessWidget {
  static const List<int?> options = [null, 1, 2, 3, 4];

  final int? selected;
  final ValueChanged<int?> onChanged;

  const GuestFilterRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((option) {
        final label = option == null ? 'Any' : '$option+';
        final isSelected = option == selected;
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) => onChanged(option),
        );
      }).toList(),
    );
  }
}
