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
}
