// import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/models/room_model.dart';
// import 'room_card.dart';


// class RoomList extends StatelessWidget {
//   final List<Room> rooms;
//   final Room? selectedRoom;
//   final bool Function(Room room) isRoomAvailable;
//   final ValueChanged<Room> onRoomSelected;

//   const RoomList({
//     super.key,
//     required this.rooms,
//     required this.selectedRoom,
//     required this.isRoomAvailable,
//     required this.onRoomSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (rooms.isEmpty) {
//       return  Padding(
//         padding: EdgeInsets.symmetric(vertical: 24),
//         child: Center(child: Text('No rooms match the selected filter.')),
//       );
//     }

//     return ListView.separated(
//       shrinkWrap: true,
//       physics:  NeverScrollableScrollPhysics(),
//       itemCount: rooms.length,
//       separatorBuilder: (_, __) =>  SizedBox(height: 8),
//       itemBuilder: (context, index) {
//         final room = rooms[index];
//         return RoomCard(
//           room: room,
//           isSelected: room == selectedRoom,
//           isAvailable: isRoomAvailable(room),
//           onTap: () => onRoomSelected(room),
//         );
//       },
//     );
//   }
// }

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
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE4E8EE),
          ),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 38,
              color: Color(0xFF9AA3B1),
            ),
            SizedBox(height: 12),
            Text(
              'No rooms found',
              style: TextStyle(
                color: Color(0xFF293346),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Try selecting a different guest count.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF8A93A1),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rooms.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
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
