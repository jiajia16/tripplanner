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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Where to next, Christabel?',
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'Destination'),
            controller: regionController,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration:
                const InputDecoration(labelText: 'Check-in Date (YYYY-MM-DD)'),
            controller: checkInController,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration:
                const InputDecoration(labelText: 'Check-out Date (YYYY-MM-DD)'),
            controller: checkOutController,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(labelText: 'No.of Adults'),
            controller: adultsController,
          ),
          ElevatedButton(
            //TODO Design UI
            child: const Text('SAVE'),
            onPressed: () async {
              Region _region =
                  await ApiCalls().getRegionId(regionController.text);
              tripDetails = TripDetails(
                regionId: _region.regionId,
                regionName: _region.regionName,
                country: _region.country,
                checkIn: checkInController.text,
                checkOut: checkOutController.text,
                adults: int.parse(adultsController.text),
              );
              FirebaseCalls().updateTrip(tripDetails);
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }
}
