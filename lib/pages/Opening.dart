import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Opening extends StatefulWidget {
  @override
  _OpeningState createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  bool isFirstTime;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value){
      setState(() {
        isFirstTime = value.getBool("isFirstTime") ?? false;
        //isFirstTime = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 1), ()  {
      !isFirstTime?Navigator.pushReplacementNamed(context, '/home'):Navigator.pushReplacementNamed(context, '/introduction');
    });

    return Scaffold(
      body: Container(
        child: Center(child: Image(image: AssetImage('assets/opening.png'))),
      ),
    );
  }
}
