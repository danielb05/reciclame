import 'dart:async';

import 'package:flutter/material.dart';

class Opening extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return Scaffold(
      body: Container(
        child: Center(child: Image(image: AssetImage('assets/opening.png'))),
      ),
    );
  }
}
