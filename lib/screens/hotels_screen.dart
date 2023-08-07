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
                  hintText: 'Explore hotels...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 2,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(text: 'Featured'),
                            Tab(text: 'All'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListView.builder(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 15.0),
                                itemCount: _filteredHotels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Hotel hotel = _filteredHotels[index];
                                  return Card(
                                    margin: EdgeInsets.only(right: 22.0),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    elevation: 0.0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/hotelDetail',
                                            arguments: hotel);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image:
                                              NetworkImage(hotel.propertyImage),
                                          fit: BoxFit.cover,
                                          scale: 2.0,
                                        )),
                                        width: 200.0,
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Color(0xFFFE8C68),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          hotel.name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 6.0,
                                                        ),
                                                        Text(
                                                          '\$${hotel.price}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Review Score ${hotel.reviewScore}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
