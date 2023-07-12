import 'package:flutter/material.dart';
import 'package:tripplanner/models/hotelDetails.dart';

import '../utilities/api_calls.dart';
import '../utilities/firebase_calls.dart';
import '../models/hotel.dart';
import '../widgets/navigation_bar.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({Key? key}) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO Read the received argument as Hotel

    return Scaffold(
      //TODO Show name of hotel in AppBar
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      //TODO Shows image of property, review score, price of hotel
      //TODO Makes fetchHotelDetails API request
      //TODO Display hotel detailed information such as rating, address, whatsAround, mapUrl, etc (refer to HotelDetails object)
      //TODO ElevatedButton – Calls FirebaseCalls().addHotel() to save hotel to savedHotels collection in Firebase
    );
  }
}
