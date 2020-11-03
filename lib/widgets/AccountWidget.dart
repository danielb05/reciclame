import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';

import '../constants.dart';
import '../main.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({
    Key key,
    @required this.fullname,
    @required this.email,
    @required this.level,
    @required this.location,
    @required this.isLogged
  }) : super(key: key);

  final String fullname;
  final String email;
  final int level;
  final String location;
  final isLogged;

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {

  void _changeLanguage(String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocale(context, _locale);
  }

  String _getLanguageCode(){
    return MyApp.getLang(context).split('_')[0];
  }

  String dropdownValue;
  List<String> itemsLanguage = ['en','es'];

  @override
  void initState() {
    setState(() {
      dropdownValue = _getLanguageCode();
    });
    super.initState();
  }

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
                  backgroundImage: widget.isLogged?AssetImage('assets/avatar.jpg'):AssetImage('assets/anonymous.jpg'),
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
              Text('${widget.fullname}',
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
              Text('${widget.email}',
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
              Text('${widget.level}',
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
              Text('${widget.location}',
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
              DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                height: 2,
                color: kPrimaryColor,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    _changeLanguage(newValue);
                  });
                },
                items:itemsLanguage.map((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(getTranslated(context, value)),
                );
                }).toList(),
                )
            ],
          ),
        ));
  }
}