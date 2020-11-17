import 'package:flutter/material.dart' show BorderRadius, BoxDecoration, BoxShadow, Color, Colors, FontWeight, Offset, TextStyle;

const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);


//Validators
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor introduzca su email";
const String kNullError = "Valor vacio.";
const String kInvalidEmailError = "Por favor introduzca un email valido";
const String kPassNullError = "Por favor introduzca su contraseña";
const String kShortPassError = "Contraseña muy corta";
const String kMatchPassError = "La contraseña no coincide";

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFd8f3dc),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);