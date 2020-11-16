import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/components/FormError.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reciclame/models/custom_user.dart';
import '../../constants.dart';

class FormSignUp extends StatefulWidget {
  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp>{

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String uid;
  bool isAdmin;
  String fullName;
  String avatarRef;
  String city;
  String postalCode;
  int score;
  DateTime createdOn;
  DateTime updatedOn;
  bool enable;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error)){
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }

  _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password:password
      );

      CollectionReference userData = FirebaseFirestore.instance.collection('userData');
      var user = new CustomUser(userCredential.user.uid,false,fullName,"default",postalCode,city,0,true);
      userData.add(user.toJson()).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      Navigator.pushReplacementNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email.'),backgroundColor: Colors.red,));
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(height: 10),
          buildEmailFormField(),
          SizedBox(height: 10),
          buildPasswordFormField(),
          SizedBox(height: 10),
          buildPostalCodeFormField(),
          SizedBox(height: 10),
          buildCityFormField(),
          SizedBox(height: 10),
          FormError(errors:errors),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              child: Text('Continue',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  )
              ),
              onPressed:() {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  FutureBuilder(
                      future: _signUp(),
                      builder: (context, snapshot){
                        print('In Builder');
                      }
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "Introduzca su nombre y apellidos",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_circle_rounded,color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildPostalCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => postalCode = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Postal Code",
        hintText: "Introduzca su codigo postal",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.pin_drop_sharp,color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Ciudad",
        hintText: "Introduzca su ciudad",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.map_outlined,color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Introduzca su email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.alternate_email,color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, "password"),
        hintText: "Introduzca su contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline_rounded,color: kPrimaryColor),
      ),
    );
  }
}
