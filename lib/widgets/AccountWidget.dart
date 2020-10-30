import 'package:flutter/material.dart';
import '../constants.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    Key key,
    @required this.fullname,
    @required this.email,
    @required this.level,
    @required this.location,
    @required this.language,
    @required this.isLogged
  }) : super(key: key);

  final String fullname;
  final String email;
  final int level;
  final String location;
  final isLogged;
  final Map<String, String> language;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: isLogged?AssetImage('assets/avatar.jpg'):AssetImage('assets/anonymous.jpg'),
                  radius: 40.0,
                ),
              ),
              Divider(
                height: 40,
                color: kPrimaryColor,
              ),
              Text('Name'.toUpperCase(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('$fullname',
                  style:
                  TextStyle(color: Colors.black, letterSpacing: 2.0)),
              SizedBox(height: 20.0),
              Text('Email'.toUpperCase(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('$email',
                  style:
                  TextStyle(color: Colors.black, letterSpacing: 2.0)),
              SizedBox(height: 20.0),
              Text('Level'.toUpperCase(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('$level',
                  style:
                  TextStyle(color: Colors.black, letterSpacing: 2.0)),
              SizedBox(height: 20.0),
              Text('Location'.toUpperCase(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('$location',
                  style:
                  TextStyle(color: Colors.black, letterSpacing: 2.0)),
              SizedBox(height: 20.0),
              Text('Language'.toUpperCase(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      letterSpacing: 2.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text(language['en_US'],
                  style:
                  TextStyle(color: Colors.black, letterSpacing: 2.0)),

            ],
          ),
        ));
  }
}