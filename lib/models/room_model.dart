class Room {
  final String code;
  final String type;
  final double pricePerNight;
  final int maxGuests;

  const Room({
    required this.code,
    required this.type,
    required this.pricePerNight,
    required this.maxGuests,
  });

  @override
  bool operator ==(Object other) => other is Room && other.code == code;

  @override
  int get hashCode => code.hashCode;
}