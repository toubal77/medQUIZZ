import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future usernameShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email')!;
  }

  @override
  void initState() {
    usernameShared();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
      DatabaseMethods().updateSettings(username).then((value) {
        usernameController.text = '';
        emailController.text = '';
        Navigator.of(context).pop();
      }).catchError((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error to update profile'),
          ),
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderProfile(title: 'Settings'),
              SizedBox(
                height: 40.h,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            labelText: 'Votre Nom',
                            labelStyle: TextStyle(
                              fontSize: 15.0.sp,
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.cyanAccent,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            usernameController.text = value!.trim();
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 15.0.sp,
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.cyanAccent,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
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
                          height: 20.h,
                        ),
                        if (isLoading == false)
                          GestureDetector(
                            onTap: () {
                              _submitForm(
                                usernameController.text.trim(),
                                emailController.text.trim(),
                              );
                            },
                            child: Container(
                              width: 200.w,
                              padding: EdgeInsets.symmetric(vertical: 15.sp),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Text(
                                'Confirme',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: 20.h,
                            child: const CircularProgressIndicator(),
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
