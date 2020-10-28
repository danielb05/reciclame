import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
// TODO: create form to connect with API and verify the user, after that save the token or user credentials (session) and redirect to /home
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('login form'),
      ),
    );
  }
}
