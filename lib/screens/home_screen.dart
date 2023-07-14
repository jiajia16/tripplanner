import 'package:flutter/material.dart';

import '../utilities/firebase_calls.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Planner'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Your next trip, ${auth.currentUser?.displayName}",
            textAlign: TextAlign.center,
          ),
          Text(
            "${tripDetails.regionName} , ${tripDetails.country}",
            textAlign: TextAlign.center,
          ),
          Text(
            "${tripDetails.checkIn} to ${tripDetails.checkOut}",
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/hotels');
              },
              child: Text('SEARCH HOTELS'))
        ],
      ),
    );
  }
}
