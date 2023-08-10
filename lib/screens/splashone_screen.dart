import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashOneScreen extends StatefulWidget {
  const SplashOneScreen({Key? key}) : super(key: key);

  @override
  State<SplashOneScreen> createState() => _SplashOneScreenState();
}

class _SplashOneScreenState extends State<SplashOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 30.0, right: 5.0),
            child: Column(
              children: [
                Text(
                  'TRIPPLANNER',
                  style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  "Welcome to Tripplanner, Let's search for a hotel! ",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 300,
                  width: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/splashScreenOne.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Login to get started'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                      elevation: 15,
                      side: BorderSide(color: Colors.white, width: 2),
                      fixedSize: Size(250, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
