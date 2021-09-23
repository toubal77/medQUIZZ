import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {
  Future<DocumentSnapshot?> getUserInfo() async {
    try {
      final DocumentSnapshot _userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(AuthService().getUserId)
          .get();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _userData['email'].toString());
      prefs.setString('username', _userData['username'].toString());
      return _userData;
    } catch (err) {
      // ignore: avoid_print
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
          // ignore: avoid_print
          (value) => print('update settings seccus'),
        )
        .catchError(
          // ignore: avoid_print
          (value) => print('update settings field $value'),
        );
  }

  Future sendSuggestion(String message) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      final String? username = prefs.getString('username');
      await FirebaseFirestore.instance
          .collection('suggestion')
          .add({
            'idUser': AuthService().getUserId,
            'time': DateTime.now().toIso8601String(),
            'email': email,
            'username': username,
            'message': message,
          })
          // ignore: avoid_print
          .then((value) => print('send suggestion with seccus'))
          // ignore: avoid_print
          .catchError((value) => print('send suggestion field $value'));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<String?> getYearsUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('years')!;
  }

  Future choiseYears(String years) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('years', years);
      final String? userId = AuthService().getUserId;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
            'time': DateTime.now().toIso8601String(),
            'years': years,
          })
          // ignore: avoid_print
          .then((value) => print('send suggestion with seccus'))
          // ignore: avoid_print
          .catchError((value) => print('send suggestion field $value'));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future addDocumentUser(User user, String username, String years) async {
    user.getIdToken().then((String token) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            'id': user.uid,
            'email': user.email,
            'username': username,
            'token': token,
            'years': years,
          })
          // ignore: avoid_print
          .then((value) => print("document user added : users : $user"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to add document : $error"));
    });
  }

  Future<void> updateTokenUser(User user) async {
    user.getIdToken().then((String token) async {
      getYearsFromDatabase(user);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'token': token,
          })
          // ignore: avoid_print
          .then((value) => print("update Token user"))
          .catchError(
            // ignore: avoid_print
            (error) => print("Failed to update token user info: $error"),
          );
    });
  }

  Future<void> getYearsFromDatabase(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final String yearsUser = snapshot.data()!['years'].toString();

    prefs.setString('years', yearsUser);
  }

  Future sendPost(String message, File? urlImage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
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
          'time': DateTime.now().toIso8601String(),
          'username': username,
          'message': message,
          'url': url,
        })
        // ignore: avoid_print
        .then((value) => print("send post"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to send post: $error"));
  }

  Future sendCommentaire(String idPost, String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .collection('commentaires')
        .add({
          'idUser': AuthService().getUserId,
          'time': DateTime.now().toIso8601String(),
          'username': username,
          'message': message,
        })
        // ignore: avoid_print
        .then((value) => print("send commentaire post"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to commentaire post: $error"));
  }

  Future deleteComnt(String idPost, String idComnt) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .collection('commentaires')
        .doc(idComnt)
        .delete()
        // ignore: avoid_print
        .then((value) => print("delete commentaire"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete commentaire: $error"));
  }

  Future deletePost(String idPost) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .delete()
        // ignore: avoid_print
        .then((value) => print("delete posts"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete posts: $error"));
  }

  Future sendSignale(String idPost, String type) async {
    await FirebaseFirestore.instance
        .collection('signale')
        .add({
          'idPost': idPost,
          'type': type,
          'idUser': AuthService().getUserId,
          'time': DateTime.now().toIso8601String(),
        })
        // ignore: avoid_print
        .then((value) => print("delete posts"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to delete posts: $error"));
  }

  Future updatePost(String message, String idPost) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .update({
          'time': DateTime.now().toIso8601String(),
          'message': message,
        })
        // ignore: avoid_print
        .then((value) => print("update post"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update post: $error"));
  }

  Future<List<Modules?>?> getModules() async {
    List<Modules?> list = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? years = prefs.getString('years');
    try {
      // ignore: avoid_print
      print(years);
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      final response = await http.post(
        url,
        body: {
          'years': years,
        },
      );
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('seccus get module');
        final data = json.decode(response.body);
        final rest = data["modules"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Modules>((json) => Modules.fromJson(json)).toList();

        return list;
      } else {
        // ignore: avoid_print
        print('field get module');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try get module');
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<List<Modules?>?> mostPopular() async {
    List<Modules?> list = [];
    try {
      final url = Uri.parse(
        'https://rayanzinotblans.000webhostapp.com/get_most_popular.php',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('seccus get module most popular');
        final data = json.decode(response.body);
        final rest = data["modules"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Modules>((json) => Modules.fromJson(json)).toList();

        return list;
      } else {
        // ignore: avoid_print
        print('field get module most popular');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try get module most popular');
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future sendScore(String correct, String incorrect, String module) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? annee = prefs.getString('years');
    await FirebaseFirestore.instance
        .collection('scores')
        .doc(AuthService().getUserId)
        .collection('modules')
        .add({
          'correct': int.parse(correct),
          'incorrect': int.parse(incorrect),
          'module': module,
          'annee': annee,
          'time': DateTime.now().toIso8601String(),
        })
        // ignore: avoid_print
        .then((value) => print("Score Data added with seccus"))
        // ignore: avoid_print
        .catchError((error) => print("Failed score Data"));
  }

  Future updateView(String idMod) async {
    try {
      final url = Uri.parse(
        'https://rayanzinotblans.000webhostapp.com/updateViewModule.php',
      );
      final response = await http.post(
        url,
        body: {
          'id_mod': idMod,
        },
      );
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          // ignore: avoid_print
          print('seccus update View Module');
        } else {
          // ignore: avoid_print
          print(json.decode(response.body)['message']);
        }
      } else {
        // ignore: avoid_print
        print('field update View Module');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try update View Module');
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<List<Questions?>?> getQuestions() async {
    List<Questions?>? list = [];
    try {
      final url = Uri.parse(
        'https://rayanzinotblans.000webhostapp.com/get_question.php',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('seccus get question');
        final data = json.decode(response.body);
        final rest = data["questions"] as List;

        // ignore: join_return_with_assignment
        list = rest.map<Questions>((json) => Questions.fromJson(json)).toList();

        return list;
      } else {
        // ignore: avoid_print
        print('field get question');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try get question');
    }
  }

  Future<List<Diagnostics?>?> getDiag() async {
    List<Diagnostics?>? list = [];
    try {
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_diag.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('seccus get diagnostics');
        final data = json.decode(response.body);
        final rest = data["diag"] as List;

        // ignore: join_return_with_assignment
        list = rest
            .map<Diagnostics>((json) => Diagnostics.fromJson(json))
            .toList();

        return list;
      } else {
        // ignore: avoid_print
        print('field get diangostics');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try get diangostics');
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
