// import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/models/room_model.dart';


// class RoomCard extends StatelessWidget {
//   final Room room;
//   final bool isSelected;
//   final bool isAvailable;
//   final VoidCallback? onTap;

//   const RoomCard({
//     super.key,
//     required this.room,
//     required this.isSelected,
//     required this.isAvailable,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final disabled = !isAvailable;

//     return Opacity(
//       opacity: disabled ? 0.5 : 1,
//       child: Card(
//         elevation: isSelected ? 3 : 1,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side: BorderSide(
//             color: isSelected ? theme.colorScheme.primary : Colors.transparent,
//             width: 2,
//           ),
//         ),
//         child: ListTile(
//           onTap: disabled ? null : onTap,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           leading: CircleAvatar(
//             backgroundColor: theme.colorScheme.primaryContainer,
//             child: Text(
//               room.code.substring(1, 2),
//               style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
//             ),
//           ),
//           title: Text('${room.type} • ${room.code}'),
//           subtitle: Text(
//             disabled
//                 ? 'Not available for the selected dates'
//                 : 'Up to ${room.maxGuests} guests',
//           ),
//           trailing: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 '₹${room.pricePerNight.toStringAsFixed(0)}',
//                 style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const Text('per night', style: TextStyle(fontSize: 11)),
//             ],
//           ),
//           selected: isSelected,
//         ),
//       ),
//     );
//   }
// }

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
    final disabled = !isAvailable;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: disabled ? 0.55 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF173B65)
                    : const Color(0xFFE5E9EF),
                width: isSelected ? 1.8 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    isSelected ? 0.08 : 0.035,
                  ),
                  blurRadius: isSelected ? 16 : 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Room icon
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFEAF1F8),
                            Color(0xFFDCE8F3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.bed_outlined,
                        color: Color(0xFF173B65),
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 13),

                    // Room details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  room.type,
                                  style: const TextStyle(
                                    color: Color(0xFF172033),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF173B65)
                                        .withOpacity(0.09),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Selected',
                                    style: TextStyle(
                                      color: Color(0xFF173B65),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Room ${room.code}',
                            style: const TextStyle(
                              color: Color(0xFF8A93A1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              const Icon(
                                Icons.people_outline_rounded,
                                size: 16,
                                color: Color(0xFF737D8C),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Up to ${room.maxGuests} guests',
                                style: const TextStyle(
                                  color: Color(0xFF737D8C),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  height: 1,
                  color: const Color(0xFFF0F2F5),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    // Availability
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: disabled
                                  ? const Color(0xFFD65C5C)
                                  : const Color(0xFF3BA776),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              disabled
                                  ? 'Unavailable'
                                  : 'Available',
                              style: TextStyle(
                                color: disabled
                                    ? const Color(0xFFB24B4B)
                                    : const Color(0xFF348B63),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${room.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF172033),
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          'per night',
                          style: TextStyle(
                            color: Color(0xFF8A93A1),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
