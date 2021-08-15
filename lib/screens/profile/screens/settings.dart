import 'package:flutter/material.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/services/database.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  Future _submitForm(String username, String email) async {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      DatabaseMethods().editProfile(email, username).then(
        (result) {
          if (result == true)
            Navigator.of(context).pop();
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result.toString()),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderProfile(title: 'Settings'),
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                            ),
                            labelText: 'Votre Nom',
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
                            usernameController.text = value!.trim();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'veuillez entrer un email valide';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!.trim();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isLoading == false
                            ? GestureDetector(
                                onTap: () {
                                  _submitForm(
                                    usernameController.text.trim(),
                                    emailController.text.trim(),
                                  );
                                },
                                child: Container(
                                  width: 200,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Text(
                                    'Confirme',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 20,
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
