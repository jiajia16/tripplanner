import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({Key? key, required this.selectedIndexNavBar})
      : super(key: key);
  int selectedIndexNavBar;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _onTap(int index) {
    widget.selectedIndexNavBar = index;
    setState(() {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/savedHotels');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/tripDetails');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/nearbyPlaces');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Saved Hotels',
          icon: Icon(
            Icons.hotel,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Trip Details',
          icon: Icon(
            Icons.luggage,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Nearby Places',
          icon: Icon(
            Icons.near_me_rounded,
          ),
        ),
      ],
      currentIndex: widget.selectedIndexNavBar,
      onTap: _onTap,
      selectedItemColor:
          Colors.purpleAccent, // Set the color for the selected item
      unselectedItemColor: Colors.black, // Set the color for unselected items
      showUnselectedLabels: true, // To show labels for unselected items
      type: BottomNavigationBarType.fixed,
    );
  }
}
