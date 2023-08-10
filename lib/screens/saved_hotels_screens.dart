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
        backgroundColor: Colors.purpleAccent,
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
                print(doc);
                Hotel hotel = Hotel(
                    id: doc['id'],
                    name: doc['name'],
                    propertyImage: doc['propertyImage'],
                    price: doc['price'],
                    reviewScore: doc['reviewScore']);
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/hotelDetail',
                        arguments: hotel);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.network(
                                doc['propertyImage'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doc['name'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.rate_review_sharp,
                                        color: Colors.purpleAccent,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${doc['reviewScore']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    doc['price'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // child: Column(
                            //   children: [
                            //     Text(doc['name']),
                            //     Text('${doc['reviewScore']}'),
                            //     Text(doc['price']),
                            //   ],
                            // ),
                          ),
                        ],
                      ),
                      // ListTile(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, '/hotelDetail',
                      //         arguments: hotel);
                      //   },
                      //   leading: Image.network(doc['propertyImage']),
                      //   title: Text(doc['name']),
                      //   subtitle: Text('${doc['reviewScore']}'),
                      //   trailing: Text(doc['price']),
                      // ),
                    ),
                  ),
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
