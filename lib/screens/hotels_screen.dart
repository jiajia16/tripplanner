import 'package:flutter/material.dart';

import '../utilities/api_calls.dart';
import '../utilities/firebase_calls.dart';
import '../models/hotel.dart';
import '../widgets/navigation_bar.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({Key? key}) : super(key: key);

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      //TODO Display name of City
      //TODO FutureBuilder to make fetchHotels API call and show list of hotels
      //TODO Each hotel is displayed in ListTile and when tapped, navigate to HotelDetailScreen with hotel as argument
    );
  }
}
