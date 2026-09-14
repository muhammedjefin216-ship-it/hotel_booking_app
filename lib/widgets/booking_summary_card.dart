import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room_model.dart';

class BookingSummaryCard extends StatelessWidget {
  final Room room;
  final int nights;
  final double totalPrice;

  const BookingSummaryCard({
    super.key,
    required this.room,
    required this.nights,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            _SummaryRow(label: 'Room', value: '${room.type} (${room.code})'),
            _SummaryRow(label: 'Nights', value: '$nights'),
            _SummaryRow(
              label: 'Total Price',
              value: '₹${totalPrice.toStringAsFixed(2)}',
              emphasize: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = theme.colorScheme.onPrimaryContainer;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: onColor)),
          Text(
            value,
            style: TextStyle(
              color: onColor,
              fontWeight: emphasize ? FontWeight.bold : FontWeight.normal,
              fontSize: emphasize ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
