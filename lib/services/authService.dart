import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:reciclame/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();

  AuthService._internal();

  factory AuthService() => instance;

  login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var userData = await UserService.instance
          .getCurrentUserData(userCredential.user.uid);
      userData['email'] = userCredential.user.email;
      setCredentials(userData);
      return "successful";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  setCredentials(data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUser', jsonEncode(data));
  }

  getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUser') != null
        ? jsonDecode(prefs.getString('currentUser'))
        : null;
  }

  removeCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    await removeCredentials();
  }

  isLogged() {
    return !(FirebaseAuth.instance.currentUser == null ?? false);
  }
}
