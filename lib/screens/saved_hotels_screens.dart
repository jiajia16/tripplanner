import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/firebase_calls.dart';
import '../widgets/navigation_bar.dart';

class SavedHotelsScreen extends StatefulWidget {
  const SavedHotelsScreen({Key? key}) : super(key: key);

  @override
  State<SavedHotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<SavedHotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Hotels'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      //TODO StreamBuilder to read hotels from savedHotelsCollection
    );
  }
}
