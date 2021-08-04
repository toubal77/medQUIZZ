import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_quizz/helper/api.dart';

class AuthService {
  Future singIn(String email, String password) async {
    try {
      var url = Uri.parse(ApiHealper.singIn);
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print('seccus to login');
        if (json.decode(response.body)['status']) {
          return true;
        } else {
          return json.decode(response.body)['message'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future singUp(String email, String password, String name) async {
    try {
      var url = Uri.parse(ApiHealper.singIn);
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
        'name': name,
      });
      if (response.statusCode == 200) {
        print('seccus to login');
        if (json.decode(response.body)['status']) {
          return true;
        } else {
          return json.decode(response.body)['message'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
