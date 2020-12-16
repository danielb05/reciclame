import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciclame/components/FormError.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/models/custom_user.dart';

import '../../constants.dart';

class FormSignUp extends StatefulWidget {
  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
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
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference userData =
          FirebaseFirestore.instance.collection('userData');
      var user = new CustomUser(userCredential.user.uid, false, fullName,
          "default", city, postalCode, 0, true);
      userData
      .doc(userCredential.user.uid)
          .set(user.toJson())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(getTranslated(context, 'account_exist'),
                textAlign: TextAlign.center),
            backgroundColor: Colors.red));
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
          FormError(errors: errors),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 56.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              child: Text(getTranslated(context, 'continue'),
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await _signUp();
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
          removeError(error: getTranslated(context, 'kNullError'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kNullError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'full_name'),
        hintText: getTranslated(context, 'enter_fullname'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_circle_rounded, color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildPostalCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => postalCode = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'kNullError'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kNullError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'postalcode'),
        hintText: getTranslated(context, 'enter_postalcode'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.pin_drop_sharp, color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'kNullError'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kNullError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'city'),
        hintText: getTranslated(context, 'enter_city'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.map_outlined, color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'kEmailNullError'));
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: getTranslated(context, 'kInvalidEmailError'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kEmailNullError'));
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: getTranslated(context, 'kInvalidEmailError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'email'),
        hintText: getTranslated(context, 'enter_email'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.alternate_email, color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'kPassNullError'));
        } else if (value.length >= 8) {
          removeError(error: getTranslated(context, 'kShortPassError'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kPassNullError'));
          return "";
        } else if (value.length < 8) {
          addError(error: getTranslated(context, 'kShortPassError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, "password"),
        hintText: getTranslated(context, "enter_password"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline_rounded, color: kPrimaryColor),
      ),
    );
  }
}
