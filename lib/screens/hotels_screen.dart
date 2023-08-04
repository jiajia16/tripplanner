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
        backgroundColor: Colors.purpleAccent,
        title: const Text('Hotels'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      body: SafeArea(
        child: FutureBuilder<List<Hotel>>(
          future: ApiCalls().fetchHotels(tripDetails),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Hotel hotel = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/hotelDetail',
                          arguments: hotel);
                    },
                    leading: Image.network(hotel.propertyImage),
                    title: Text(hotel.name),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.purple,
                          size: 18,
                        ),
                        Text('${hotel.reviewScore}'),
                      ],
                    ),
                    trailing: Text(hotel.price),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
