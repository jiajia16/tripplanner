import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:tripplanner/models/nearby_response.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  String apiKey = "AIzaSyBkK_yGDQ_ZY-Gdwv9mqKXC9_x9eLOJVgc";
  String radius = "30";

  double latitude = 1.3800;
  double longtitude = 103.8489;

  NearbyPlacesResponse nearByPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('Nearby Places'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                getNearbyPlaces();
              },
              child: Text('Get Nearby Places'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purpleAccent,
                shadowColor: Colors.cyan,
                side: BorderSide(color: Colors.white, width: 2),
                shape: StadiumBorder(),
              ),
            ),
            if (nearByPlacesResponse.results != null)
              for (int i = 0; i < nearByPlacesResponse.results!.length; i++)
                nearbyPlacesWidget(nearByPlacesResponse.results![i])
          ],
        ),
      ),
    );
  }

  void getNearbyPlaces() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longtitude&radius=$radius&key=$apiKey');

    var response = await http.post(url);

    nearByPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    setState(() {});
  }

  Widget nearbyPlacesWidget(Results results) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('Name of place: ' + results.name!),
          SizedBox(
            height: 5,
          ),
          Text('Location: ' +
              results.geometry!.location!.lat.toString() +
              "," +
              results.geometry!.location!.lng.toString()),
          SizedBox(
            height: 5,
          ),
          Text(results.openingHours != null ? 'Open' : "Closed"),
        ],
      ),
    );
  }
}
