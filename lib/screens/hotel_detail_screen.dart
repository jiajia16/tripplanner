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
        backgroundColor: Colors.purpleAccent,
        title: Text(hotel.name),
      ),
      body: SafeArea(
        child: FutureBuilder<HotelDetails>(
          future: ApiCalls().fetchHotelDetails(hotel.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HotelDetails hotelDetails = snapshot.data!;
              return Container(
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
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
                      ClipRect(
                        child: Container(
                          child: Column(
                            children: [],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${hotelDetails.tagline}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${hotel.price}',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                'total price',
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.rate_review_sharp,
                            color: Colors.purple,
                          ),
                          Text(
                            ' Rating ${(hotelDetails.rating).toString()}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'DESCRIPTION',
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('${hotelDetails.whatsAround}'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(
                            Icons.location_on_sharp,
                            size: 20,
                            color: Colors.purple,
                          ),
                          const SizedBox(width: 5),
                          Expanded(child: Text('${hotelDetails.address}')),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8), // Adjust the radius as needed
                          child: Image.network(
                            hotelDetails.mapUrl,
                            width: 400, // Set the desired width of the image
                            height: 100, // Set the desired height of the image
                            fit: BoxFit
                                .cover, // Adjust the fit to your preference
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FirebaseCalls().addHotel(hotel);
                            },
                            child: Text('SAVE'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              shadowColor: Colors.cyan,
                              side: BorderSide(color: Colors.white, width: 2),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
