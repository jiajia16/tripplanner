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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Where to next, ${auth.currentUser?.displayName}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_sharp),
                  labelText: 'Destination',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: regionController,
              ),
              SizedBox(height: 20),
              buildDateField(
                label: 'Check-in Date',
                controller: checkInController,
                icon: Icons.calendar_today,
              ),
              SizedBox(height: 20),
              buildDateField(
                label: 'Check-out Date',
                controller: checkOutController,
                icon: Icons.calendar_today,
              ),
              SizedBox(height: 20),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervisor_account),
                  labelText: 'No. of Adults',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: adultsController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                //TODO Design UI
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () => _selectDate(context, controller),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text.isNotEmpty
                  ? '$label: ${controller.text}'
                  : 'Select $label',
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.text.isNotEmpty
          ? DateTime.parse(controller.text)
          : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      controller.text = picked.toString().split(' ')[0];
    }
  }
}
