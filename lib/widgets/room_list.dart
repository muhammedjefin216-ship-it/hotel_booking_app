import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/room_model.dart';
import 'room_card.dart';


class RoomList extends StatelessWidget {
  final List<Room> rooms;
  final Room? selectedRoom;
  final bool Function(Room room) isRoomAvailable;
  final ValueChanged<Room> onRoomSelected;

  const RoomList({
    super.key,
    required this.rooms,
    required this.selectedRoom,
    required this.isRoomAvailable,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return  Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('No rooms match the selected filter.')),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      itemCount: rooms.length,
      separatorBuilder: (_, __) =>  SizedBox(height: 8),
      itemBuilder: (context, index) {
        final room = rooms[index];
        return RoomCard(
          room: room,
          isSelected: room == selectedRoom,
          isAvailable: isRoomAvailable(room),
          onTap: () => onRoomSelected(room),
        );
      },
    );
  }
}
