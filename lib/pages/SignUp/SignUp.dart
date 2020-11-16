import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reciclame/constants.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // Create button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/login');
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text(getTranslated(context, 'thanks_sign_up')),
        content: Text(getTranslated(context, 'welcome') + userName.text+ " !"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green[700],
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, 'title').toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
                  child: FormSignUp()
                ));
  }
}
