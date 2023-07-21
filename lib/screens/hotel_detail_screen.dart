import 'package:flutter/material.dart';
import 'package:tripplanner/models/hotelDetails.dart';

import '../utilities/api_calls.dart';
import '../utilities/firebase_calls.dart';
import '../models/hotel.dart';
import '../widgets/navigation_bar.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({Key? key}) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO Read the received argument as Hotel
    final Hotel hotel = ModalRoute.of(context)?.settings.arguments as Hotel;
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: SafeArea(
        child: FutureBuilder<HotelDetails>(
          future: ApiCalls().fetchHotelDetails(hotel.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HotelDetails hotelDetails = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(hotel.propertyImage), // image
                    Text(
                        'Review Score: ${(hotel.reviewScore).toString()}'), // review score
                    Text('Price : ${hotel.price}'), // amount price
                    Text(
                        'Rating: ${(hotelDetails.rating).toString()}'), // rating
                    Text('Address: ${hotelDetails.address}'), // address
                    Text(
                        'Hotel Description: ${hotelDetails.whatsAround}'), // description
                    Image.network(hotelDetails.mapUrl),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseCalls().addHotel(hotel);
                        },
                        child: Text('SAVE'))
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      //TODO Show name of hotel in AppBar
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      //TODO Shows image of property, review score, price of hotel
      //TODO Makes fetchHotelDetails API request
      //TODO Display hotel detailed information such as rating, address, whatsAround, mapUrl, etc (refer to HotelDetails object)
      //TODO ElevatedButton – Calls FirebaseCalls().addHotel() to save hotel to savedHotels collection in Firebase
    );
  }
}
