import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripplanner/screens/nearby_screen.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../widgets/navigation_bar.dart';

class NearByPlaces extends StatefulWidget {
  const NearByPlaces({Key? key}) : super(key: key);

  @override
  State<NearByPlaces> createState() => _NearByPlacesState();
}

const kGoogleApiKey = 'AIzaSyBkK_yGDQ_ZY-Gdwv9mqKXC9_x9eLOJVgc';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _NearByPlacesState extends State<NearByPlaces> {
  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(1.3521, 103.8198), zoom: 14.0);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("Nearby Places"),
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
            child: Stack(children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                initialCameraPosition: initialPosition,
                markers: markers,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
              ),
              ElevatedButton(
                onPressed: _handlePressButton,
                child: const Text("Search For Places"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purpleAccent,
                  shadowColor: Colors.cyan,
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: StadiumBorder(),
                ),
              )
            ]),
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
          backgroundColor: Colors.purpleAccent,
          label: const Text("Current location"),
          icon: const Icon(Icons.location_history)),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "sg"),
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
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
