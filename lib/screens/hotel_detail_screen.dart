import 'package:flutter/material.dart';
import 'package:tripplanner/models/hotelDetails.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageSlideshow(
                      width: double.infinity,
                      height: 300,
                      initialPage: 0,
                      indicatorColor: Colors.cyan,
                      indicatorBackgroundColor: Colors.white,
                      autoPlayInterval: 3000,
                      isLoop: true,
                      children: [
                        Image.network(
                          hotel.propertyImage,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          hotelDetails.propertyImageTwo,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          hotelDetails.propertyImageThree,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          hotelDetails.propertyImageFour,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          hotelDetails.propertyImageFive,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '${hotelDetails.tagline}',
                          style: TextStyle(fontSize: 17),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${(hotel.reviewScore).toString()}',
                                style: TextStyle(
                                    color: Colors.orangeAccent, fontSize: 16),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_sharp,
                          size: 20,
                          color: Colors.cyan,
                        ),
                        const SizedBox(width: 5),
                        Text('${hotelDetails.address}'),
                      ],
                    ),
                    Text(
                      'Price : ${hotel.price}',
                      style: TextStyle(fontSize: 15),
                    ), // amount price
                    Text(
                      'Rating: ${(hotelDetails.rating).toString()}',
                      style: TextStyle(fontSize: 15),
                    ),

                    Text(
                      'DETAILS',
                      textAlign: TextAlign.left,
                    ),
                    Text('${hotelDetails.whatsAround}'), // description
                    Image.network(
                      hotelDetails.mapUrl,
                    ),
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
