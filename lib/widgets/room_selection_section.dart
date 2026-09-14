import 'package:flutter/material.dart';

import '../models/room_model.dart';
import 'room_list.dart';
import 'validation_banner.dart';

class RoomSelectionSection extends StatelessWidget {
  final List<Room> rooms;
  final Room? selectedRoom;
  final bool Function(Room room) isRoomAvailable;
  final ValueChanged<Room> onRoomSelected;

  final bool showUnavailableMessage;

  const RoomSelectionSection({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.isRoomAvailable,
    required this.onRoomSelected,
    this.showUnavailableMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE4E8EE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF173B65).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.king_bed_outlined,
                  color: Color(0xFF173B65),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose your room',
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Select an available room for your stay',
                      style: TextStyle(
                        color: Color(0xFF8A93A1),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF173B65).withOpacity(0.07),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${rooms.length} rooms',
                  style: const TextStyle(
                    color: Color(0xFF173B65),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          RoomList(
            rooms: rooms,
            selectedRoom: selectedRoom,
            isRoomAvailable: isRoomAvailable,
            onRoomSelected: onRoomSelected,
          ),

          if (showUnavailableMessage && selectedRoom != null) ...[
            const SizedBox(height: 12),
            const ValidationBanner(
              message:
                  'This room is already booked for the selected dates. '
                  'Please choose different dates or another room.',
            ),
          ],
        ],
      ),
    );
  }
}