import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/hotel_detail_screen.dart';
import '../screens/trip_details_screen.dart';
import '../screens/hotels_screen.dart';
import '../screens/saved_hotels_screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/tripDetails': (context) => const TripDetailsScreen(),
        '/hotels': (context) => const HotelsScreen(),
        '/hotelDetail': (context) => const HotelDetailScreen(),
        '/savedHotels': (context) => const SavedHotelsScreen(),
      },
    );
  }
}
