import 'package:flutter/material.dart';
import 'package:reciclame/components/FormError.dart';
import 'package:reciclame/localization/language_constants.dart';
import 'package:reciclame/services/authService.dart';

import '../../constants.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
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

  _login() async {
    switch (await AuthService.instance.login(email, password)) {
      case "successful":
        Navigator.pop(context);
        Navigator.pop(context);
        break;
      case 'user-not-found':
        print('No user found for that email.');
        break;
      case "wrong-password":
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(getTranslated(context, 'wrong_e_p'),
                textAlign: TextAlign.center),
            backgroundColor: Colors.red));
        break;
      default:
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(getTranslated(context, 'smth_wrong'),
                textAlign: TextAlign.center),
            backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 30),
          FormError(errors: errors),
          SizedBox(height: 30),
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
                  await _login();
                }
              },
            ),
          )
        ],
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
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'kPassNullError'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'password'),
        hintText: getTranslated(context, 'enter_password'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline_rounded, color: kPrimaryColor),
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
}
