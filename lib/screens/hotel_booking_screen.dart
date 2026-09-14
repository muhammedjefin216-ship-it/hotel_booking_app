import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/room_data.dart';
import 'package:hotel_booking_app/domain/booking_service.dart';
import 'package:hotel_booking_app/models/existing_booking_model.dart';
import 'package:hotel_booking_app/models/room_model.dart';
import '../widgets/booking_summary_card.dart';
import '../widgets/date_selector_field.dart';
import '../widgets/guest_filter_row.dart';
import '../widgets/room_list.dart';
import '../widgets/validation_banner.dart';

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

  late final List<ExistingBooking> _existingBookings = buildMockExistingBookings();

  List<Room> get _filteredRooms {
    if (_guestFilter == null) return mockRooms;
    return mockRooms.where((room) => room.maxGuests >= _guestFilter!).toList();
  }

  bool _isRoomAvailable(Room room) {
    if (_checkIn == null || _checkOut == null) return true;
    final validation = BookingCalculator.validateDates(
      checkIn: _checkIn,
      checkOut: _checkOut,
    );
    if (!validation.isValid) return true; 
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
    setState(() => _checkOut = date);
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

    final roomAvailable = _selectedRoom != null && _isRoomAvailable(_selectedRoom!);

   
    final canShowSummary = dateValidation.isValid && _selectedRoom != null && roomAvailable;

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
      appBar: AppBar(title:  Text('Hotel Room Booking')),
      body: SafeArea(
        child: ListView(
          padding:  EdgeInsets.all(16),
          children: [
            Text('1. Choose your dates', style: Theme.of(context).textTheme.titleMedium),
             SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DateSelectorField(
                    label: 'Check-in',
                    selectedDate: _checkIn,
                    firstSelectableDate: BookingCalculator.dateOnly(DateTime.now()),
                    onDateSelected: _onCheckInSelected,
                  ),
                ),
                 SizedBox(width: 12),
                Expanded(
                  child: DateSelectorField(
                    label: 'Check-out',
                    selectedDate: _checkOut,
                    firstSelectableDate: _checkIn != null
                        ? _checkIn!.add( Duration(days: 1))
                        : BookingCalculator.dateOnly(DateTime.now()).add( Duration(days: 1)),
                    onDateSelected: _onCheckOutSelected,
                  ),
                ),
              ],
            ),
            if (!dateValidation.isValid && (_checkIn != null || _checkOut != null)) ...[
               SizedBox(height: 12),
              ValidationBanner(message: dateValidation.message!),
            ],
             SizedBox(height: 24),

            Text('2. Filter by guests (optional)', style: Theme.of(context).textTheme.titleMedium),
             SizedBox(height: 8),
            GuestFilterRow(selected: _guestFilter, onChanged: _onGuestFilterChanged),
             SizedBox(height: 24),

            Text('3. Select a room', style: Theme.of(context).textTheme.titleMedium),
             SizedBox(height: 8),
            RoomList(
              rooms: _filteredRooms,
              selectedRoom: _selectedRoom,
              isRoomAvailable: _isRoomAvailable,
              onRoomSelected: _onRoomSelected,
            ),

            if (_selectedRoom != null && dateValidation.isValid && !roomAvailable) ...[
               SizedBox(height: 12),
               ValidationBanner(
                message: 'This room is already booked for the selected dates. '
                    'Please choose different dates or another room.',
              ),
            ],

             SizedBox(height: 24),
            if (canShowSummary)
              BookingSummaryCard(
                room: _selectedRoom!,
                nights: nights,
                totalPrice: totalPrice,
              )
            else
              Text(
                'Select valid dates and an available room to see your booking summary.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
              ),
          ],
        ),
      ),
    );
  }
}
