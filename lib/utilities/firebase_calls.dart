import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tripplanner/models/hotelDetails.dart';

import '../models/hotel.dart';
import '../models/tripDetails.dart';

FirebaseAuth auth = FirebaseAuth.instance;

CollectionReference tripDetailsCollection =
    FirebaseFirestore.instance.collection('tripDetails');
CollectionReference savedHotelsCollection =
    FirebaseFirestore.instance.collection('savedHotels');

late TripDetails tripDetails; //to store details of trip
bool newUser = false; // to indicate if this is a new user

class FirebaseCalls {
  Future<TripDetails> getTripDetails(String uid) async {
    QuerySnapshot querySnap =
        await tripDetailsCollection.where('userid', isEqualTo: uid).get();

    if (querySnap.docs.isNotEmpty) {
      QueryDocumentSnapshot doc = querySnap.docs[0];

      tripDetails = TripDetails(
        // get trip details from database, if there is data
        regionId: doc.get('regionId'),
        regionName: doc.get('regionName'),
        country: doc.get('country'),
        checkIn: doc.get('checkIn'),
        checkOut: doc.get('checkOut'),
        adults: doc.get('adults'),
      );
    } else {
      // if is a new person, give empty screen as default
      // set default values for new user
      newUser = true;
      tripDetails = TripDetails(
        regionId: '',
        regionName: '',
        country: '',
        checkIn: '',
        checkOut: '',
        adults: 1,
      );
    }

    return tripDetails;
  }

  Future<void> updateTrip(TripDetails tripDetails) async {
    if (newUser) {
      //New User - Add
      await tripDetailsCollection.add({
        'regionId': tripDetails.regionId,
        'regionName': tripDetails.regionName,
        'country': tripDetails.country,
        'checkIn': tripDetails.checkIn,
        'checkOut': tripDetails.checkOut,
        'adults': tripDetails.adults,
        'userid': auth.currentUser?.uid
      });
      newUser = false;
    } else {
      // Existing user - Update
      QuerySnapshot querySnap = await tripDetailsCollection
          .where('userid', isEqualTo: auth.currentUser?.uid)
          .get();
      QueryDocumentSnapshot doc = querySnap.docs[0];

      await tripDetailsCollection.doc(doc.id).update({
        'regionId': tripDetails.regionId,
        'regionName': tripDetails.regionName,
        'country': tripDetails.country,
        'checkIn': tripDetails.checkIn,
        'checkOut': tripDetails.checkOut,
        'adults': tripDetails.adults,
      });
    }
  }

  Future<void> addHotel(Hotel hotel) async {
    await savedHotelsCollection
        .add({
          'id': hotel.id,
          'name': hotel.name,
          'propertyPrice': hotel.propertyImage,
          'price': hotel.price,
          'reviewScore': hotel.reviewScore,
        })
        .then((value) => print("hotel added"))
        .catchError((error) => print("Failed to add task: $error"));
  }
}
