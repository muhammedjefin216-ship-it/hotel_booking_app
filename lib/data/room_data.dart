import 'package:hotel_booking_app/models/existing_booking_model.dart';
import 'package:hotel_booking_app/models/room_model.dart';



 List<Room> mockRooms = [
  Room(code: 'R101', type: 'Deluxe Room', pricePerNight: 3500, maxGuests: 2),
  Room(code: 'R102', type: 'Deluxe Room', pricePerNight: 3500, maxGuests: 2),
  Room(code: 'R201', type: 'Executive Suite', pricePerNight: 5800, maxGuests: 3),
  Room(code: 'R202', type: 'Executive Suite', pricePerNight: 5800, maxGuests: 3),
  Room(code: 'R301', type: 'Family Room', pricePerNight: 4200, maxGuests: 4),
];


List<ExistingBooking> buildMockExistingBookings() {
  final today = DateTime.now();
  DateTime daysFromNow(int days) =>
      DateTime(today.year, today.month, today.day).add(Duration(days: days));

  return [
    ExistingBooking(
      roomCode: 'R101',
      checkIn: daysFromNow(2),
      checkOut: daysFromNow(5),
    ),
    ExistingBooking(
      roomCode: 'R201',
      checkIn: daysFromNow(1),
      checkOut: daysFromNow(3),
    ),
  ];
}
