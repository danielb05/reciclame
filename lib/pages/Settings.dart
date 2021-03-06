import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/authService.dart';
import 'package:reciclame/widgets/AccountWidget.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  final Map arguments;

  Settings(this.arguments);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isLogged;
  String email;
  String fullname;
  int level;
  String location;

  @override
  void initState() {
    super.initState();

    setState(() {
      isLogged = AuthService.instance.isLogged();
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _logout() async {
    await AuthService.instance.logout();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

  RaisedButton sessionButton() {
    return !(isLogged ?? false)
        ? RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Text(getTranslated(context, 'log_in'),
                style: TextStyle(color: kTextColor)),
            color: kPrimaryColor,
          )
        : RaisedButton(
            onPressed: () async {
              await _logout();
            },
            color: Colors.redAccent,
            child: Text(getTranslated(context, 'close_session')));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AccountWidget(isLogged: (isLogged ?? false)),
                Spacer(),
                Divider(color: kTextColor),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: sessionButton()))
              ],
            )),
      ),
      onWillPop: () {
        Navigator.pop(context);
      },
    );
  }
}
