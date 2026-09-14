import 'package:flutter/material.dart';

import 'package:hotel_booking_app/data/room_data.dart';
import 'package:hotel_booking_app/domain/booking_service.dart';
import 'package:hotel_booking_app/models/existing_booking_model.dart';
import 'package:hotel_booking_app/models/room_model.dart';

import '../widgets/booking_header.dart';
import '../widgets/booking_summary_card.dart';
import '../widgets/room_selection_section.dart';
import '../widgets/stay_details_card.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  Room? _selectedRoom;
  int? _guestFilter;

  late final List<ExistingBooking> _existingBookings =
      buildMockExistingBookings();

  List<Room> get _filteredRooms {
    if (_guestFilter == null) {
      return mockRooms;
    }

    return mockRooms.where((room) => room.maxGuests >= _guestFilter!).toList();
  }

  bool _isRoomAvailable(Room room) {
    if (_checkIn == null || _checkOut == null) {
      return true;
    }

    final validation = BookingCalculator.validateDates(
      checkIn: _checkIn,
      checkOut: _checkOut,
    );

    if (!validation.isValid) {
      return true;
    }

    return BookingCalculator.isRoomAvailable(
      roomCode: room.code,
      checkIn: _checkIn!,
      checkOut: _checkOut!,
      existingBookings: _existingBookings,
    );
  }

  void _onCheckInSelected(DateTime date) {
    setState(() {
      _checkIn = date;

      if (_checkOut != null && !_checkOut!.isAfter(date)) {
        _checkOut = null;
      }
    });
  }

  void _onCheckOutSelected(DateTime date) {
    setState(() {
      _checkOut = date;
    });
  }

  void _onRoomSelected(Room room) {
    setState(() {
      _selectedRoom = _selectedRoom == room ? null : room;
    });
  }

  void _onGuestFilterChanged(int? value) {
    setState(() {
      _guestFilter = value;

      if (_selectedRoom != null && !_filteredRooms.contains(_selectedRoom)) {
        _selectedRoom = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateValidation = BookingCalculator.validateDates(
      checkIn: _checkIn,
      checkOut: _checkOut,
    );

    final roomAvailable =
        _selectedRoom != null && _isRoomAvailable(_selectedRoom!);

    final canShowSummary =
        dateValidation.isValid && _selectedRoom != null && roomAvailable;

    int nights = 0;
    double totalPrice = 0;

    if (canShowSummary) {
      nights = BookingCalculator.calculateNights(_checkIn!, _checkOut!);

      totalPrice = BookingCalculator.calculateTotalPrice(
        nights: nights,
        pricePerNight: _selectedRoom!.pricePerNight,
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF172033),
        centerTitle: false,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hotel Booking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2),
            Text(
              'Find your perfect room',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7B8494),
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            // Header
            BookingHeader(),

            SizedBox(height: 20),

            StayDetailsCard(
              checkIn: _checkIn,
              checkOut: _checkOut,
              guestFilter: _guestFilter,
              onCheckInSelected: _onCheckInSelected,
              onCheckOutSelected: _onCheckOutSelected,
              onGuestFilterChanged: _onGuestFilterChanged,
              dateValidation: dateValidation,
            ),

            SizedBox(height: 20),

            RoomSelectionSection(
              rooms: _filteredRooms,
              selectedRoom: _selectedRoom,
              isRoomAvailable: _isRoomAvailable,
              onRoomSelected: _onRoomSelected,
              showUnavailableMessage:
                  _selectedRoom != null &&
                  dateValidation.isValid &&
                  !roomAvailable,
            ),

            SizedBox(height: 20),

            if (canShowSummary)
              BookingSummaryCard(
                room: _selectedRoom!,
                nights: nights,
                totalPrice: totalPrice,
              ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
