class ExistingBooking{
  final String roomCode;
  final DateTime checkIn;
  final DateTime checkOut;

  const ExistingBooking({
    required this.roomCode,
    required this.checkIn,
    required this.checkOut,
  });
}