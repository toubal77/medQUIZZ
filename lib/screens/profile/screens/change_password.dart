import 'package:flutter/material.dart';
import 'package:med_quizz/screens/profile/widgets/header_profile.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
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
      AuthService().resetPass(password).then((result) {
        passwordController.text = '';

        Navigator.of(context).pop();
      }).catchError((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('vous devez ce reconnecte pour change votre mot de passe'),
          ),
        );
      });
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
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderProfile(title: 'Change Password'),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            labelText: 'New Password',
                            labelStyle: TextStyle(
                              fontSize: 15.0.sp,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.trim().isEmpty &&
                                value.trim().length < 8) {
                              return "Password Can't be last then 8 ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController.text = value!.trim();
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: confPasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            labelText: 'Confirme Password',
                            labelStyle: TextStyle(
                              fontSize: 15.0.sp,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Can't be empty";
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
                          height: 20.h,
                        ),
                        if (isLoading == false)
                          GestureDetector(
                            onTap: () {
                              _submitForm(
                                passwordController.text.trim(),
                              );
                            },
                            child: Container(
                              width: 200.w,
                              padding: EdgeInsets.symmetric(vertical: 15.sp),
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
                        else
                          SizedBox(
                            height: 20.h,
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
