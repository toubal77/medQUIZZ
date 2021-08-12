import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_quizz/helper/api.dart';

class AuthService {
  Future<String?> singIn(String email, String password) async {
    try {
      var url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/login.php');
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('seccus to login');
          return 'Login';
        } else {
          print('fetch to login');
          return json.decode(response.body)['message'];
        }
      }
    } on Exception catch (e) {
      print('fetch catch to login');
      print(e.toString());
      return 'Error in server';
    }
  }

  Future<String?> singUp(String email, String password, String name) async {
    try {
      var url = Uri.parse(ApiHealper.singIn);
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
        'name': name,
      });
      if (response.statusCode == 200) {
        if (json.decode(response.body)['status']) {
          print('seccus to login');
          return 'Login';
        } else {
          print('sfetch to login');
          return json.decode(response.body)['message'];
        }
      }
    } catch (e) {
      print('fetch catch to login');
      print(e.toString());
      return 'Error in server';
    }
  }
}