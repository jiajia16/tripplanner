import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';
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

      body: StreamBuilder<QuerySnapshot>(
        stream: savedHotelsCollection
            .where('userid', isEqualTo: auth.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot doc = snapshot.data!.docs[index];
                Hotel hotel = Hotel(
                    id: doc['id'],
                    name: doc['name'],
                    propertyImage: doc['propertyImage'],
                    price: doc['price'],
                    reviewScore: doc['reviewScore']);
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/savedHotels',
                        arguments: hotel);
                  },
                  leading: Image.network(doc['propertyImage']),
                  title: Text(doc['name']),
                  subtitle: Text('${doc['reviewScore']}'),
                  trailing: Text(doc['price']),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      //TODO StreamBuilder to read hotels from savedHotelsCollection
    );
  }
}
