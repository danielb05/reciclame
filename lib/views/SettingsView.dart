import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/widgets/AccountWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> {
  bool isLogged;
  String  email;
  String fullname;
  int level;
  String location;
  var language = {'en_US': 'English'};

  @override
  void initState() {
    super.initState();
    _getCredentials();
  }

  _getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogged = prefs.getString('email') == null ? false : true;
      email = prefs.getString('email') != null ? "admin@gmail.com" : '-';
      fullname = prefs.getString('fullname') != null ? prefs.getString('fullname') : 'Anonymous';
      level = prefs.getInt('level') != null ? prefs.getInt('level') : 1;
      location = prefs.getInt('level') != null ? prefs.getString('location'): 'Undefined';
    });
  }

  _initCredentials() async {
    email = "-";
    fullname = "Anonymous";
    level = 1;
    location = 'Undefined';
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/home');
  }

  RaisedButton sessionButton() {
    return !isLogged
        ? RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child:
                Text(getTranslated(context, 'log_in'), style: TextStyle(color: kTextColor)),
            color: kPrimaryColor,
          )
        : RaisedButton(
            onPressed: () {
              FutureBuilder(
                  future: _logout(),
                  builder: (context, snapshot){
                    print('In Builder');
                  });
            },
            color: Colors.redAccent,
            child: Text(getTranslated(context, 'close_session')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AccountWidget(fullname: fullname, email: email, level: level, location: location,isLogged: isLogged??false),
            Spacer(),
            Divider(color: kTextColor),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                    alignment: Alignment.bottomCenter, child: sessionButton()))
          ],
        ));
  }
}
