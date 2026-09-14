import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room_model.dart';


class RoomCard extends StatelessWidget {
  final Room room;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.room,
    required this.isSelected,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabled = !isAvailable;

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Card(
        elevation: isSelected ? 3 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: ListTile(
          onTap: disabled ? null : onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              room.code.substring(1, 2),
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
          title: Text('${room.type} • ${room.code}'),
          subtitle: Text(
            disabled
                ? 'Not available for the selected dates'
                : 'Up to ${room.maxGuests} guests',
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${room.pricePerNight.toStringAsFixed(0)}',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Text('per night', style: TextStyle(fontSize: 11)),
            ],
          ),
          selected: isSelected,
        ),
      ),
    );
  }
}
