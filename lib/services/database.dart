import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_quizz/models/modules.dart';

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
}
