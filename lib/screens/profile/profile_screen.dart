import 'package:flutter/material.dart';
import 'package:med_quizz/screens/profile/components/profile_menu.dart';
import 'package:med_quizz/screens/profile/screens/change_password.dart';
import 'package:med_quizz/screens/profile/screens/settings.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/screens/profile/widgets/user_info.dart';
import 'package:med_quizz/services/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController suggController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    UserInfo(),
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
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: suggController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderSide: new BorderSide(),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30.0)),
                                          ),
                                          labelText: 'Votre Suggestion',
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Can\'t be empty';
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
                                        Container(
                                          width: 100,
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text("Annule"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text("send"),
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
                                                      if (result == true)
                                                        Navigator.of(context)
                                                            .pop();
                                                      else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(result
                                                                .toString()),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  );
                                                } catch (e) {
                                                  return print(e.toString());
                                                }
                                              },
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
                  'Note l\'applications',
                  Icons.low_priority_sharp,
                  () {},
                ),
                ProfileMenu(
                  'Partage l\'applications',
                  Icons.share,
                  () {},
                ),
                ProfileMenu(
                  'Log Out',
                  Icons.exit_to_app,
                  () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
