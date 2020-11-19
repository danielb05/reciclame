import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();

  AuthService._internal();

  factory AuthService() => instance;

  login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "successful";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  isLogged() {
    return !(FirebaseAuth.instance.currentUser == null ?? false);
  }
}
