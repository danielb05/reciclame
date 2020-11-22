import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/pages/SignUp/FormSignUp.dart';

void main() {
  runApp(SignUp());
}

TextEditingController emailValue = new TextEditingController();
TextEditingController passwordValue = new TextEditingController();
TextEditingController confirmPasswordValue = new TextEditingController();
TextEditingController userName = new TextEditingController();
TextEditingController fullName = new TextEditingController();
TextEditingController phoneNumberValue = new TextEditingController();
TextEditingController errorMessage = new TextEditingController();

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              getTranslated(context, 'title').toUpperCase(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: FormSignUp()));
  }
}
