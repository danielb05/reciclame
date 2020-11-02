import 'package:flutter/material.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/pages/Home.dart';
import 'package:reciclame/pages/Login.dart';
import 'package:reciclame/pages/SignUp.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {'/home': (context) => Home(),
                  '/login': (context) => Login(),
                  '/signup': (context) => SignUp(),
        },
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity)
    );
  }
}
