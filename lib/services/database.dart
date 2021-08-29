import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {
  Future<DocumentSnapshot?> getUserInfo() async {
    try {
      DocumentSnapshot _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService().getUserId)
          .get();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _userData['email']);
      prefs.setString('username', _userData['username']);
      return _userData;
    } catch (err) {
      print(err);
    }
  }

  Future updateSettings(String username) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUserId)
        .update({
          'username': username,
        })
        .then(
          (value) => print('update settings seccus'),
        )
        .catchError(
          (value) => print('update settings field ' + value),
        );
  }

  Future sendSuggestion(String message) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      String? username = prefs.getString('username');
      await FirebaseFirestore.instance
          .collection('suggestion')
          .add({
            'idUser': AuthService().getUserId,
            'time': DateTime.now().toIso8601String(),
            'email': email,
            'username': username,
            'message': message,
          })
          .then((value) => print('send suggestion with seccus'))
          .catchError((value) => print('send suggestion field ' + value));
    } catch (e) {
      print(e.toString());
    }
  }

  Future addDocumentUser(User user, String username) async {
    user.getIdToken().then((String token) async {
      print('The user ID token is' + token);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            'id': user.uid,
            'email': user.email,
            'username': username,
            'token': token,
          })
          .then((value) => print("document user added : users : $user"))
          .catchError((error) => print("Failed to add document : $error"));
    });
  }

  Future<void> updateTokenUser(User user) async {
    user.getIdToken().then((String token) async {
      print('The user ID token is ' + token);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'token': token,
          })
          .then((value) => print("update Token user"))
          .catchError(
              (error) => print("Failed to update token user info: $error"));
    });
  }

  Future sendPost(String message, File? urlImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    var url = '';
    if (urlImage != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('Posts')
          .child(urlImage.toString());
      await ref.putFile(urlImage);
      url = await ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .add({
          'idUser': AuthService().getUserId,
          'time': DateTime.now(),
          'username': username,
          'message': message,
          'url': url,
        })
        .then((value) => print("send post"))
        .catchError((error) => print("Failed to send post: $error"));
  }

  Future sendCommentaire(String idPost, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .collection('commentaires')
        .add({
          'idUser': AuthService().getUserId,
          'time': DateTime.now(),
          'username': username,
          'message': message,
        })
        .then((value) => print("send commentaire post"))
        .catchError((error) => print("Failed to commentaire post: $error"));
  }

  Future<List<Modules?>?> getModules() async {
    List<Modules?> list = [];
    try {
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get module');
        final data = json.decode(response.body);
        final rest = data["modules"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Modules>((json) => Modules.fromJson(json)).toList();

        return list;
      } else {
        print('field get module');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get module');
      print(e.toString());
    }
  }

  Future<List<Modules?>?> mostPopular() async {
    List<Modules?> list = [];
    try {
      final url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/get_most_popular.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get module most popular');
        final data = json.decode(response.body);
        final rest = data["modules"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Modules>((json) => Modules.fromJson(json)).toList();

        return list;
      } else {
        print('field get module most popular');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get module most popular');
      print(e.toString());
    }
  }

  Future updateView(String idMod) async {
    try {
      final url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/updateViewModule.php');
      final response = await http.post(url, body: {
        'id_mod': idMod,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('seccus update View Module');
        } else {
          print(json.decode(response.body)['message']);
        }
      } else {
        print('field update View Module');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try update View Module');
      print(e.toString());
    }
  }

  Future<List<Questions?>?> getQuestions() async {
    List<Questions?>? list = [];
    try {
      final url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/get_question.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get question');
        final data = json.decode(response.body);
        final rest = data["questions"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Questions>((json) => Questions.fromJson(json)).toList();

        return list;
      } else {
        print('field get question');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get question');
      print(e.toString());
    }
  }

  Future<List<Diagnostics?>?> getDiag() async {
    List<Diagnostics?>? list = [];
    try {
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_diag.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get diagnostics');
        final data = json.decode(response.body);
        final rest = data["diag"] as List;

        // ignore: join_return_with_assignment
        list = rest
            .map<Diagnostics>((json) => Diagnostics.fromJson(json))
            .toList();

        return list;
      } else {
        print('field get diangostics');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get diangostics');
      print(e.toString());
    }
  }
}
