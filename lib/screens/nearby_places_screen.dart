import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/nearby_screen.dart';

import '../widgets/navigation_bar.dart';

class NearByPlaces extends StatefulWidget {
  const NearByPlaces({Key? key}) : super(key: key);

  @override
  State<NearByPlaces> createState() => _NearByPlacesState();
}

class _NearByPlacesState extends State<NearByPlaces> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(1.3521, 103.8198), zoom: 14.0);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Google Map"),
        centerTitle: true,
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 3),
      body: Column(
        children: [
          ListTile(
            title: Text('Find places near me'),
            leading: Icon(Icons.near_me),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NearbyScreen()));
            },
          ),
          Expanded(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: initialPosition,
              markers: markers,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinePosition();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));
            markers.clear();
            markers.add(Marker(
                markerId: MarkerId('currentLocation'),
                position: LatLng(position.latitude, position.longitude)));
            setState(() {});
          },
          label: const Text("Current location"),
          icon: const Icon(Icons.location_history)),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
