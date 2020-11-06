import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reciclame/constants.dart';
import 'package:reciclame/localization/language_constants.dart';

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
                      'Reciclame',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          TextField(
                            controller: fullName,
                            decoration: InputDecoration(
                                labelText: 'Full name:',
                                suffixIcon: Icon(Icons.person),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: userName,
                            decoration: InputDecoration(
                                labelText: 'Username',
                                suffixIcon: Icon(Icons.verified_user),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: emailValue,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: getTranslated(context, "email"),
                                suffixIcon: Icon(Icons.email),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: passwordValue,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: getTranslated(context, "password"),
                                suffixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: confirmPasswordValue,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: getTranslated(context, 'confirm_password'),
                                suffixIcon: Icon(Icons.lock),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: phoneNumberValue,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: getTranslated(context,'phone_number'),
                                suffixIcon: Icon(Icons.phone),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                              color: kPrimaryColor,
                              child: Text(getTranslated(context,'sign_up').toUpperCase()),
                              onPressed: (){
                                errorMessage.text="";
                                print('hello');
                                if(passwordValue.text !=confirmPasswordValue.text){
                                  errorMessage.text += getTranslated(context,'password_not_match');
                                }
                                if (passwordValue.text.isEmpty || phoneNumberValue.text.isEmpty || confirmPasswordValue.text.isEmpty ||
                                    emailValue.text.isEmpty  ||userName.text.isEmpty ){
                                  errorMessage.text += "All fields are mandatory! \n \n";
                                }
                                if(errorMessage.text.isEmpty){
                                  showAlertDialog(context);
                                }
                                  _formKey.currentState.save();
                              }
                          ),
                          SizedBox(height: 20, width: 40,),
                          TextField(
                            controller: errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
  }
}
