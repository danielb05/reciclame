import 'package:flutter/material.dart';
import 'package:reciclame/widgets/SettingsWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView();

  @override
  _SettingsState createState() => _SettingsState();

}

class _SettingsState extends State<SettingsView> {
  bool isLogged = false;

  RaisedButton sessionButton (){
  return !isLogged ? RaisedButton(
      onPressed: (){
        Navigator.pushNamed(context, '/login');
      },
      child: Text('Log in / Sign up',
        style: TextStyle(
          color: kTextColor
        )),
      color: kPrimaryColor,
  )
      :
  RaisedButton(
      onPressed: (){
        setState(() {
          isLogged = false;
          //Remove credentials
        });
      },
      color: Colors.redAccent,
      child: Text('Close session')
  );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((storage){
      print(storage.getString('email'));
      storage.getString('email') == null ? this.isLogged=false : this.isLogged=true;
    });
    print(this.isLogged);
    //No works
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          SettingsWidget(),
          Spacer(),
          Divider(color: kTextColor),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: sessionButton()
                ))
        ],
      )
    );
  }
}
