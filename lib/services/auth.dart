import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_quizz/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  const AuthUser({
    required this.uid,
  });
  final String uid;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUser? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return AuthUser(uid: user.uid);
    } else {
      return null;
    }
  }

  Stream<AuthUser?> get onAuthStateChanged {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      DatabaseMethods().updateTokenUser(user!);
      return _userFromFirebaseUser(user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future signUpEmailPassword(
    String email,
    String password,
    String username,
    String years,
  ) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('years', years);
      DatabaseMethods().addDocumentUser(user!, username, years);
      return _userFromFirebaseUser(user);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  String? get getUserId {
    final String? _userId = FirebaseAuth.instance.currentUser?.uid;
    return _userId;
  }

  Future resetPass(String password) async {
    _auth.currentUser!
        .updatePassword(password)
        .then(
          // ignore: avoid_print
          (value) => print('update password seccus'),
        )
        .catchError(
          // ignore: avoid_print
          (value) => print('update password field $value'),
        );
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
