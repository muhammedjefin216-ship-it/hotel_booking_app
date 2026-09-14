// import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/models/room_model.dart';

// class BookingSummaryCard extends StatelessWidget {
//   final Room room;
//   final int nights;
//   final double totalPrice;

//   const BookingSummaryCard({
//     super.key,
//     required this.room,
//     required this.nights,
//     required this.totalPrice,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       color: theme.colorScheme.primaryContainer,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding:  EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Booking Summary',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 color: theme.colorScheme.onPrimaryContainer,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//              SizedBox(height: 8),
//             _SummaryRow(label: 'Room', value: '${room.type} (${room.code})'),
//             _SummaryRow(label: 'Nights', value: '$nights'),
//             _SummaryRow(
//               label: 'Total Price',
//               value: '₹${totalPrice.toStringAsFixed(2)}',
//               emphasize: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SummaryRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final bool emphasize;

//   const _SummaryRow({
//     required this.label,
//     required this.value,
//     this.emphasize = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final onColor = theme.colorScheme.onPrimaryContainer;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(color: onColor)),
//           Text(
//             value,
//             style: TextStyle(
//               color: onColor,
//               fontWeight: emphasize ? FontWeight.bold : FontWeight.normal,
//               fontSize: emphasize ? 18 : 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF173B65),
            Color(0xFF285B8F),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF173B65).withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Booking Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.king_bed_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Room ${room.code} • Up to ${room.maxGuests} guests',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            _SummaryRow(
              label: 'Price per night',
              value: '₹${room.pricePerNight.toStringAsFixed(0)}',
            ),

            _SummaryRow(
              label: 'Number of nights',
              value: '$nights ${nights == 1 ? 'night' : 'nights'}',
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(
                color: Colors.white24,
                height: 1,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '₹${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
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

  const _SummaryRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
