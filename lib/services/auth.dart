// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:med_quizz/helper/api.dart';

// class AuthService {
//   Future<String?> singIn(String email, String password) async {
//     try {
//       final url =
//           Uri.parse('https://rayanzinotblans.000webhostapp.com/login.php');
//       final response = await http.post(url, body: {
//         "email": email,
//         "password": password,
//       });
//       if (response.statusCode == 200) {
//         if (json.decode(response.body)['status'] == true) {
//           print('seccus to login');
//           return 'Login';
//         } else {
//           print('fetch to login');
//           return json.decode(response.body)['message'].toString();
//         }
//       }
//     } on Exception catch (e) {
//       print('fetch catch to login');
//       print(e.toString());
//       return 'Error in server';
//     }
//   }

//   Future<String?> singUp(String email, String password, String name) async {
//     try {
//       final url = Uri.parse(ApiHealper.singIn);
//       final response = await http.post(url, body: {
//         'email': email,
//         'password': password,
//         'name': name,
//       });
//       if (response.statusCode == 200) {
//         if (json.decode(response.body)['status'] == true) {
//           print('seccus to login');
//           return 'Login';
//         } else {
//           print('sfetch to login');
//           return json.decode(response.body)['message'].toString();
//         }
//       }
//     } catch (e) {
//       print('fetch catch to login');
//       print(e.toString());
//       return 'Error in server';
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_quizz/services/database.dart';

class AuthUser {
  const AuthUser({
    required this.uid,
  });
  final String uid;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
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
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      DatabaseMethods().updateTokenUser(user!);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpEmailPassword(
      String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      DatabaseMethods().addDocumentUser(user!, username);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  String? get getUserId {
    String? _userId = FirebaseAuth.instance.currentUser?.uid;
    return _userId;
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
