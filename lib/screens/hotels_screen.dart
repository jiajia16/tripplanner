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

final List<String> hotels = <String>[
  'id',
  'name',
  'propertyImage',
  'price',
  'reviewScore'
];

class _HotelsScreenState extends State<HotelsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Hotel> _filteredHotels = [];
  List<Hotel> _allHotels = [];

  @override
  void initState() {
    super.initState();
    _fetchHotels();
  }

  void _fetchHotels() async {
    List<Hotel> hotels = await ApiCalls().fetchHotels(tripDetails);
    setState(() {
      _allHotels = hotels;
      _filteredHotels = hotels;
    });
  }

  void _filterHotels(String query) {
    List<Hotel> filteredList = [];
    for (var hotel in _allHotels) {
      if (hotel.name.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(hotel);
      }
    }
    setState(() {
      _filteredHotels = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          'Hotels',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterHotels,
                decoration: InputDecoration(
                  hintText: 'Search hotels...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: _filteredHotels.length,
                itemBuilder: (BuildContext context, int index) {
                  Hotel hotel = _filteredHotels[index];
                  return Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/hotelDetail',
                              arguments: hotel);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(25.0, 5.0, 20.0, 5.0),
                          height: 170.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: 140.0,
                                      child: Text(
                                        hotel.name,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      '\$${hotel.price}',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        'Review Score ${hotel.reviewScore}')),
                                SizedBox(height: 20.0)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30.0,
                        top: 15.0,
                        bottom: 15.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            hotel.propertyImage,
                            width: 140.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
