import 'package:flutter/material.dart';
import 'package:reciclame/widgets/AccountWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> {
  bool isLogged = false;
  String  email = "-";
  String fullname = "Anonymous";
  int level = 1;
  String location = "Undefined";
  var language = {'en_US': 'English'};

  @override
  void initState() {
    super.initState();
    _getCredentials();
  }

  _getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogged = (prefs.getString('email') ?? 0) == null ? false : true;
      email = prefs.getString('email') != null ? "admin@gmail.com" : '-';
      fullname = prefs.getString('fullname') != null ? prefs.getString('fullname') : 'Anonymous';
      level = prefs.getInt('level') != null ? prefs.getInt('level') : 1;
      location = prefs.getInt('level') != null ? prefs.getString('location'): 'Undefined';
    });
  }

  _initCredentials() async {
    isLogged = false;
    email = "-";
    fullname = "Anonymous";
    level = 1;
    location = 'Undefined';
  }

  _removeCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _initCredentials();
      prefs.remove('email');
      prefs.remove('fullname');
      prefs.remove('level');
      prefs.remove('location');
    });
  }

  RaisedButton sessionButton() {
    return !isLogged
        ? RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child:
                Text('Log in / Sign up', style: TextStyle(color: kTextColor)),
            color: kPrimaryColor,
          )
        : RaisedButton(
            onPressed: () {
              _removeCredentials();
              //Navigator.pushNamed(context, '/home');
            },
            color: Colors.redAccent,
            child: Text('Close session'));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AccountWidget(fullname: fullname, email: email, level: level, location: location, language: language,isLogged: isLogged),
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
