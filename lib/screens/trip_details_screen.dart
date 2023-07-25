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
        title: const Text(
          'Trip Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
      body: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Where to next, ${auth.currentUser?.displayName}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                icon: Icon(Icons.location_on_sharp),
                labelText: 'Destination',
              ),
              controller: regionController,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'Check-in Date (YYYY-MM-DD)',
                  icon: Icon(Icons.calendar_month_outlined)),
              controller: checkInController,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'Check-out Date (YYYY-MM-DD)',
                  icon: Icon(Icons.calendar_month_outlined)),
              controller: checkOutController,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'No.of Adults',
                  icon: Icon(Icons.supervisor_account)),
              controller: adultsController,
            ),
            ElevatedButton(
              //TODO Design UI
              child: const Text('SAVE'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.cyanAccent,
                  elevation: 15,
                  side: BorderSide(color: Colors.black12, width: 2),
                  fixedSize: Size(400, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
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
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
