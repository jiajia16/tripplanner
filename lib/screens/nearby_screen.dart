import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:tripplanner/models/nearby_response.dart';
import 'package:tripplanner/screens/nearby_places_screen.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  String apiKey = "AIzaSyBkK_yGDQ_ZY-Gdwv9mqKXC9_x9eLOJVgc";
  String radius = "30";

  double latitude = 1.3521;
  double longtitude = 103.8198;

  NearbyPlacesResponse nearByPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: Text('Get Nearby Places')),
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
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            latitude.toString() +
            ',' +
            longtitude.toString() +
            '&radius=' +
            radius +
            '&key=' +
            apiKey);

    var response = await http.post(url);

    nearByPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    setState(() {});
  }

  Widget nearbyPlacesWidget(Results results) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purpleAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('Name:' + results.name!),
          Text('Location' +
              results.geometry!.location!.lat.toString() +
              "," +
              results.geometry!.location!.lng.toString()),
          Text(results.openingHours != null ? 'Open' : "Closed"),
        ],
      ),
    );
  }
}
