import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

import '../utilities/firebase_calls.dart';
import '../models/tripDetails.dart';
import '../screens/trip_details_screen.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
              ],
            );
          } else {
            if (snapshot.data?.displayName == null) {
              return const ProfileScreen(
                providerConfigs: [
                  EmailProviderConfiguration(),
                ],
              );
            } else {
              //check if trip is found in TripDetails collection
              return FutureBuilder<TripDetails>(
                future: FirebaseCalls().getTripDetails(snapshot.data!
                    .uid), // read if user got use this app before, if got then just go home screen
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    if (newUser) {
                      return const TripDetailsScreen();
                    } else {
                      return const HomeScreen();
                    }
                  } else if (snapshot2.hasError) {
                    return Text('${snapshot2.error}');
                  }
                  return const CircularProgressIndicator();
                },
              );
            }
          }
        },
      ),
    );
  }
}
