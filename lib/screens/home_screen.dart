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
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 0),
      //TODO widgets to show user name and logout button
      //TODO widgets to show trip details
      //TODO ElevatedButton to navigate to HotelsScreen
    );
  }
}
