import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/hotel_booking_screen.dart';

void main(){
  runApp(HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Room Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: HotelBookingScreen(),
    );
  }
}