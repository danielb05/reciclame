import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static final AuthService instance = AuthService._internal();
  AuthService._internal();
  factory AuthService () => instance;


  login(){

  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  isLogged(){
    FirebaseAuth.instance.authStateChanges().listen((User user) {
        return !(user == null ?? false);
    });
  }




}