import 'package:flutter/material.dart';
import 'package:reciclame/components/FormError.dart';
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

  _login() async {
   switch (await AuthService.instance.login(email, password)){
     case "successful":
       Navigator.pop(context);
       Navigator.pop(context);
       break;
     case 'user-not-found':
       print('No user found for that email.');
       break;
     case  "wrong-password":
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Wrong email or password provided.',textAlign: TextAlign.center),backgroundColor: Colors.red));
       break;
     default:
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something is wrong!',textAlign: TextAlign.center),backgroundColor: Colors.red));
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
          FormError(errors:errors),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 56.0,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              child: Text('Continuar',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  )
              ),
              onPressed:() async {
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
          removeError(error: kPassNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        hintText: "Introduzca su contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline_rounded,color: kPrimaryColor),
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
}
