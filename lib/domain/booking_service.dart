import 'package:hotel_booking_app/models/existing_booking_model.dart';

class DateValidationResult {
  final bool isValid;
  final String? message;

  const DateValidationResult._(this.isValid, this.message);

  const DateValidationResult.valid() : this._(true, null);

  const DateValidationResult.invalid(String message) : this._(false, message);
}

class BookingCalculator {
  const BookingCalculator._();

  static DateTime dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
  static DateValidationResult validateDates({
    required DateTime? checkIn,
    required DateTime? checkOut,
  }) {
    if (checkIn == null || checkOut == null) {
      return const DateValidationResult.invalid(
        'Please select both a check-in and a check-out date.',
      );
    }

    final today = dateOnly(DateTime.now());
    final inDate = dateOnly(checkIn);
    final outDate = dateOnly(checkOut);

    if (inDate.isBefore(today)) {
      return const DateValidationResult.invalid(
        'Check-in date cannot be in the past.',
      );
    }

    if (!outDate.isAfter(inDate)) {
      return const DateValidationResult.invalid(
        'Check-out date must be after the check-in date.',
      );
    }

    return const DateValidationResult.valid();
  }

  static int calculateNights(DateTime checkIn, DateTime checkOut) {
    final inDate = dateOnly(checkIn);
    final outDate = dateOnly(checkOut);
    return outDate.difference(inDate).inDays;
  }

  static double calculateTotalPrice({
    required int nights,
    required double pricePerNight,
  }) {
    if (nights <= 0) return 0;
    return nights * pricePerNight;
  }

  static bool isRoomAvailable({
    required String roomCode,
    required DateTime checkIn,
    required DateTime checkOut,
    required List<ExistingBooking> existingBookings,
  }) {
    final inDate = dateOnly(checkIn);
    final outDate = dateOnly(checkOut);

    for (final booking in existingBookings) {
      if (booking.roomCode != roomCode) continue;

      final bookedIn = dateOnly(booking.checkIn);
      final bookedOut = dateOnly(booking.checkOut);

      final overlaps = inDate.isBefore(bookedOut) && outDate.isAfter(bookedIn);
      if (overlaps) return false;
    }

    return true;
  }
}
