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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: const Text(
          'Explore Hotels',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: Material(
                elevation: 20.0,
                borderRadius: BorderRadius.circular(30),
                shadowColor: Color(0x55434349),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterHotels,
                  decoration: const InputDecoration(
                    hintText: 'Search for hotels...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 400,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DefaultTabController(
                      length: 1,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: Colors.transparent,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              DefaultTextStyle(
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  fontFamily: 'Arial',
                                  color: Colors.black,
                                ),
                                child: Tab(
                                  text:
                                      'Hotels in ${tripDetails.regionName}, ${tripDetails.country}',
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 15.0),
                                  itemCount: _filteredHotels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Hotel hotel = _filteredHotels[index];
                                    return Card(
                                      margin: EdgeInsets.only(right: 22.0),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                            image: NetworkImage(
                                                hotel.propertyImage),
                                            fit: BoxFit.cover,
                                            scale: 2.0,
                                          )),
                                          width: 240.0,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFE8C68),
                                                    ),
                                                    Text(
                                                      'Review Score: ${hotel.reviewScore}',
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .amberAccent,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '\$${hotel.price}',
                                                  style: const TextStyle(
                                                    color: Colors.amberAccent,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 190,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    hotel.name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
