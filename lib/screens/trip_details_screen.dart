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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/japan.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 20.0, right: 20.0, bottom: 140.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(
                      "Where to next, ${auth.currentUser?.displayName}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on_sharp,
                          color: Colors.black,
                        ),
                        labelText: 'Destination',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: regionController,
                    ),
                    const SizedBox(height: 20),
                    buildDateField(
                      label: 'Check-in Date',
                      controller: checkInController,
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 20),
                    buildDateField(
                      icon: Icons.calendar_today,
                      label: 'Check-out Date',
                      controller: checkOutController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.supervisor_account,
                          color: Colors.black,
                        ),
                        labelText: 'No. of Adults',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: adultsController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purpleAccent,
                          elevation: 15,
                          side: BorderSide(color: Colors.white, width: 2),
                          fixedSize: Size(300, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: const Text('SAVE'),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
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
