// import 'package:flutter/material.dart';
// import 'package:hotel_booking_app/screens/hotel_booking_screen.dart';

// void main(){
//   runApp(HotelBookingApp());
// }

// class HotelBookingApp extends StatelessWidget {
//   const HotelBookingApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hotel Room Booking',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 12, 26, 103)),
//         useMaterial3: true,
//       ),
//       home: HotelBookingScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'screens/hotel_booking_screen.dart';

void main() {
  runApp(const HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173B65),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF7F8FA),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF172033),
          elevation: 0,
        ),

        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const HotelBookingScreen(),
    );
  }
}