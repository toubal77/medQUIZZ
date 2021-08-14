import 'package:flutter/material.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = new TextEditingController();
  TextEditingController confPasswordController = new TextEditingController();
  bool isLoading = false;
  Future _submitForm(String password) async {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      // DatabasesMethods().updatePassword(password).then(
      //   (result) {
      //     if (result == true)
      //       Navigator.of(context).pop();
      //     else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(result.toString()),
      //         ),
      //       );
      //     }
      //   },
      // );
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
        child: SingleChildScrollView(
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
                HeaderProfile(title: 'Change Password'),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              labelText: 'New Password',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.trim().isEmpty &&
                                  value.trim().length < 8) {
                                return 'Password Can\'t be last then 8 ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value!.trim();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confPasswordController,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              labelText: 'Confirme Password',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Can\'t be empty';
                              } else if (passwordController.text.trim() !=
                                  value.trim()) {
                                return 'Passwords not match';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              confPasswordController.text = value!.trim();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          isLoading == false
                              ? GestureDetector(
                                  onTap: () {
                                    _submitForm(
                                      passwordController.text.trim(),
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
      ),
    );
  }
}
