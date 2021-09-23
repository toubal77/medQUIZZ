import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/search/widgets/module_tile.dart';
import 'package:med_quizz/screens/search/widgets/shimmer_module_tile.dart';
import 'package:med_quizz/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late StreamSubscription subscription;
  TextEditingController pickUpController = TextEditingController();
  final List<Modules?> _search = [];
  final List<Modules?> _list = [];
  bool isLoading = false;
  Future<List<Modules?>?> getModules() async {
    setState(() {
      isLoading = true;
    });
    _list.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? years = prefs.getString('years');
    try {
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      final response = await http.post(url, body: {
        'years': years,
      });
      if (response.statusCode == 200) {
        print('seccus get module');
        final data = json.decode(response.body);
        final rest = data["modules"] as List;
        setState(() {
          for (final Map<String, dynamic> i in rest) {
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

  Future<void> onSearch(String title) async {
    _search.clear();
    if (title.isEmpty) {
      setState(() {});
      return;
    }
    // ignore: avoid_function_literals_in_foreach_calls
    _list.forEach((f) {
      if (f!.nom.contains(title)) _search.add(f);
    });
    setState(() {});
  }

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          Utils.checkConnexion(context);
        } else {
          setState(() {});
        }
      },
    );
    getModules().then((value) => setState(() {
          isLoading = false;
        }));

    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 25.sp, top: 10.sp, right: 25.sp, bottom: 20.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
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
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 18.w,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.sp),
                            child: TextField(
                              controller: pickUpController,
                              decoration: InputDecoration(
                                hintText: 'Search Module',
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.sp, top: 8.sp, bottom: 8.sp),
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
                itemCount: _search.length,
                itemBuilder: (context, index) {
                  return _search.length != 0
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
