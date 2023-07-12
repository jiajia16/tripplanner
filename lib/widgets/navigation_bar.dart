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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue.shade200,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Saved Hotels',
          icon: Icon(Icons.hotel),
        ),
        BottomNavigationBarItem(
          label: 'Trip Details',
          icon: Icon(Icons.luggage),
        ),
      ],
      currentIndex: widget.selectedIndexNavBar,
      onTap: _onTap,
    );
  }
}
