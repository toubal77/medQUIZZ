import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/search/widgets/module_tile.dart';
import 'package:med_quizz/screens/search/widgets/shimmer_module_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpController = new TextEditingController();
  List<Modules?> _search = [];
  List<Modules?> _list = [];
  var isLoading = false;
  Future<List<Modules?>?> getModules() async {
    setState(() {
      isLoading = true;
    });
    _list.clear();
    try {
      var url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get module');
        var data = json.decode(response.body);
        var rest = data["modules"] as List;
        setState(() {
          for (Map<String, dynamic> i in rest) {
            _list.add(Modules.fromJson(i));
          }
        });
      } else {
        print('field get module');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get module');
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  onSearch(String title) async {
    _search.clear();
    if (title.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((f) {
      if (f!.nom.contains(title)) _search.add(f);
    });
    setState(() {});
  }

  @override
  void initState() {
    getModules().then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _list.clear();
                          _search.clear();
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: TextField(
                              controller: pickUpController,
                              decoration: InputDecoration(
                                hintText: 'Search Module',
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 8, bottom: 8),
                              ),
                              onChanged: (value) {
                                onSearch(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _search.length,
                itemBuilder: (context, index) {
                  return _search.length == 0
                      ? ModuleTileSearch(_search[index])
                      : ShimmerModuleTileSearch();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
