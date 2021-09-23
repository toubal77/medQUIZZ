import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/auth/login_screen.dart';
import 'package:med_quizz/screens/profile/components/profile_menu.dart';
import 'package:med_quizz/screens/profile/screens/change_password.dart';
import 'package:med_quizz/screens/profile/screens/settings.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/services/database.dart';
import 'package:med_quizz/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController suggController = TextEditingController();
  late StreamSubscription subscription;
  String? dropdownValue = '1';
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
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Column(
                //   children: [
                //     HeaderProfile(title: 'Profile'),
                //       InfoUser(),
                //   ],
                // ),
                SizedBox(
                  height: 4.h,
                ),
                const HeaderProfile(title: 'Profile'),
                ProfileMenu(
                  title: 'Settings',
                  icon: Icons.settings,
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const Settings();
                        },
                      ),
                    );
                  },
                ),
                ProfileMenu(
                  title: 'Année universitaire',
                  icon: Icons.cabin,
                  press: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Center(
                                child: Text(
                                  'Selectionne votre annee:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              FutureBuilder<String?>(
                                future: DatabaseMethods().getYearsUser(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data == null) {
                                      dropdownValue = '1';
                                    } else {
                                      dropdownValue = snapshot.data;
                                    }
                                    DropdownButton<String?>(
                                      value: dropdownValue,
                                      icon: const Icon(
                                        Icons.arrow_downward,
                                        color: Colors.black,
                                      ),
                                      iconSize: 24.sp,
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String?>[
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                        '5',
                                        '6'
                                      ].map<DropdownMenuItem<String?>>(
                                        (String? value) {
                                          return DropdownMenuItem<String?>(
                                            value: value,
                                            child: Text(
                                              value!,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    height: 45.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Annule'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    height: 45.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          try {
                                            DatabaseMethods()
                                                .choiseYears(dropdownValue!)
                                                .then(
                                              (result) {
                                                suggController.text = '';
                                                Navigator.of(context).pop();
                                              },
                                            ).catchError(
                                              (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'field to send years select',
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } catch (e) {
                                            // ignore: avoid_print
                                            return print(e.toString());
                                          }
                                        },
                                        child: const Text("send"),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                ProfileMenu(
                  title: 'Change Password',
                  icon: Icons.lock,
                  press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ChangePassword();
                        },
                      ),
                    );
                  },
                ),
                ProfileMenu(
                  title: 'Suggections',
                  icon: Icons.help,
                  press: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            children: <Widget>[
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: TextFormField(
                                        controller: suggController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30.0),
                                            ),
                                          ),
                                          labelText: 'Votre Suggestion',
                                          labelStyle: TextStyle(
                                            fontSize: 15.0.sp,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return "Can't be empty";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          suggController.text = value!.trim();
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          height: 45.h,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Annule'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          height: 45.h,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                _formKey.currentState!.save();
                                                if (!_formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                try {
                                                  DatabaseMethods()
                                                      .sendSuggestion(
                                                    suggController.text.trim(),
                                                  )
                                                      .then(
                                                    (result) {
                                                      suggController.text = '';
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ).catchError(
                                                    (result) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            'field to send suggestion',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } catch (e) {
                                                  // ignore: avoid_print
                                                  return print(e.toString());
                                                }
                                              },
                                              child: const Text("send"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                ProfileMenu(
                  title: "Note l'applications",
                  icon: Icons.low_priority_sharp,
                  press: () {},
                ),
                ProfileMenu(
                  title: "Partage l'applications",
                  icon: Icons.share,
                  press: () {},
                ),
                ProfileMenu(
                  title: 'Log Out',
                  icon: Icons.exit_to_app,
                  press: () async {
                    FirebaseAuth.instance.signOut();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
