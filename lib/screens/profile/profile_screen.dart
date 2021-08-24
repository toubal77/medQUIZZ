import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_quizz/screens/auth/login_screen.dart';
import 'package:med_quizz/screens/profile/components/profile_menu.dart';
import 'package:med_quizz/screens/profile/screens/change_password.dart';
import 'package:med_quizz/screens/profile/screens/settings.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/screens/profile/widgets/user_info.dart';
import 'package:med_quizz/services/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController suggController = TextEditingController();
  late StreamSubscription subscription;
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    HeaderProfile(title: 'Profile'),
                    InfoUser(),
                  ],
                ),
                ProfileMenu(
                  'Settings',
                  Icons.settings,
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Settings();
                        },
                      ),
                    );
                  },
                ),
                ProfileMenu(
                  'Change Password',
                  Icons.lock,
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangePassword();
                        },
                      ),
                    );
                  },
                ),
                ProfileMenu(
                  'Suggections',
                  Icons.help,
                  () {
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
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30.0)),
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
                                              child: Text('Annule'),
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
                                                          suggController.text
                                                              .trim())
                                                      .then(
                                                    (result) {
                                                      suggController.text = '';
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ).catchError(
                                                    (result) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'field to send suggestion'),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } catch (e) {
                                                  return print(e.toString());
                                                }
                                              },
                                              child: Text("send"),
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
                  "Note l'applications",
                  Icons.low_priority_sharp,
                  () {},
                ),
                ProfileMenu(
                  "Partage l'applications",
                  Icons.share,
                  () {},
                ),
                ProfileMenu(
                  'Log Out',
                  Icons.exit_to_app,
                  () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) {
                        return LoginScreen();
                      }),
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
