import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/widgets/AccountWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLogged = false;
  String  email;
  String fullname;
  int level;
  String location;

  @override
  void initState() {
    super.initState();
    _getCredentials();
  }

  _getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogged = (prefs.getBool('isLogged') == null) ? false : prefs.getBool('isLogged');
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

  _removeCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('email');
      prefs.remove('fullname');
      prefs.remove('level');
      prefs.remove('location');
      prefs.remove('isLogged');
      _initCredentials();
    });
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
              _removeCredentials();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            color: Colors.redAccent,
            child: Text(getTranslated(context, 'close_session')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AccountWidget(fullname: fullname, email: email, level: level, location: location,isLogged: isLogged),
              Spacer(),
              Divider(color: kTextColor),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomCenter, child: sessionButton()))
            ],
          )),
    );
  }
}
