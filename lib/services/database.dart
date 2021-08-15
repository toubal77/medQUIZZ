import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/models/questions.dart';

class DatabaseMethods {
  Future<List<Modules?>?> getModules() async {
    List<Modules?> list = [];
    try {
      var url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get module');
        var data = json.decode(response.body);
        var rest = data["modules"] as List;

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

  Future<List<Questions?>?> getQuestions() async {
    List<Questions?>? list = [];
    try {
      var url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/get_question.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get question');
        var data = json.decode(response.body);
        var rest = data["questions"] as List;

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

  Future updatePassword(String password) async {
    try {
      var url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/update_password.php');
      var response = await http.post(url, body: {
        'id': '1',
        'password': password,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('update Password with seccus');
          return true;
        } else {
          return json.decode(response.body)['message'];
        }
      } else {
        print('field update Password');
        print(response.statusCode);
        return 'error to connecte';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future editProfile(String email, String username) async {
    try {
      var url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/update_profile.php');
      var response = await http.post(url, body: {
        'id': '1',
        'email': email,
        'username': username,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('update profile with seccus');
          return true;
        } else {
          return json.decode(response.body)['message'];
        }
      } else {
        print('field update Profile');
        print(response.statusCode);
        return 'error to connecte';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendSuggestion(String message) async {
    try {
      var url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/suggestion.php');
      var response = await http.post(url, body: {
        'email': 'toubalzineddine77@gmail.com',
        'username': 'toubal zineddine',
        'message': message,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('send suggestion with seccus');
          return true;
        } else {
          return json.decode(response.body)['message'];
        }
      } else {
        print('field to send sugestions');
        print(response.statusCode);
        return 'error to connecte';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
