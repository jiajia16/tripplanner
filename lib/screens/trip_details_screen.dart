import 'package:flutter/material.dart';

import '../models/region.dart';
import '../utilities/api_calls.dart';
import '../utilities/firebase_calls.dart';
import '../models/tripDetails.dart';
import '../widgets/navigation_bar.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  TextEditingController regionController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController adultsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    regionController.text = tripDetails.regionName;
    checkInController.text = tripDetails.checkIn;
    checkOutController.text = tripDetails.checkOut;
    adultsController.text = tripDetails.adults.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
      body: ElevatedButton(
        //TODO Design UI
        child: const Text('SAVE'),
        onPressed: () async {
          Region _region = await ApiCalls().getRegionId(regionController.text);
          tripDetails = TripDetails(
            regionId: _region.regionId,
            regionName: _region.regionName,
            country: _region.country,
            checkIn: checkInController.text,
            checkOut: checkOutController.text,
            adults: int.parse(adultsController.text),
          );
          //TODO Calls FirebaseCalls().updateTrip() to update values to Firebase
          //TODO Navigates to HomeScreen
          // get region ID base on what user enter in controller 'ApiCalls().getRegionID()'
          // get fields and save it inside database
        },
      ),
    );
  }
}
