import 'package:flutter/material.dart';
import 'package:med_quizz/screens/home_screen.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AuthMode { signup, login }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AuthMode _authMode = AuthMode.login;
  bool _isLoading = false;

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      print('sinUp');
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      print('singIn');
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  Future _submitForm() async {
    print('submit form');
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await AuthService()
            .signInEmailPassword(emailController.text, emailController.text)
            .then(
          (result) async {
            if (result != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                    // return HomePage(
                    //     'vous venez de cree un compte avec ${emailController.text}');
                  },
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(result),
                ),
              );
            }
          },
        );
      } else {
        await AuthService()
            .signUpEmailPassword(
                emailController.text, emailController.text, nameController.text)
            .then(
          (result) async {
            if (result != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                    // return HomePage(
                    //     'vous venez de cree un compte avec ${emailController.text}');
                  },
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(result),
                ),
              );
            }
          },
        );
      }
      // _authMode == AuthMode.login
      //     ? AuthService()
      //         .singIn(
      //             emailController.text.trim(), passwordController.text.trim())
      //         .then(
      //         (result) {
      //           if (result! == 'Login') {
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return HomePage();
      //                   // return HomePage(
      //                   //     'vous etes connecte avec ${emailController.text}');
      //                 },
      //               ),
      //             );
      //           } else {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 duration: Duration(seconds: 3),
      //                 content: Text(result),
      //               ),
      //             );
      //           }
      //         },
      //       )
      //     : AuthService()
      //         .singUp(emailController.text.trim(),
      //             passwordController.text.trim(), nameController.text.trim())
      //         .then(
      //         (result) {
      //           if (result! == 'Login') {
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return HomePage();
      //                   // return HomePage(
      //                   //     'vous venez de cree un compte avec ${emailController.text}');
      //                 },
      //               ),
      //             );
      //           } else {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               SnackBar(
      //                 duration: Duration(seconds: 3),
      //                 content: Text(result),
      //               ),
      //             );
      //           }
      //         },
      //       );
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _entryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_authMode == AuthMode.signup)
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  labelStyle: TextStyle(
                    fontSize: 15.0.sp,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 12.0.sp,
                    color: Colors.cyanAccent,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'votre nom est trop court';
                  }
                  return null;
                },
                onSaved: (value) {
                  nameController.text = value!;
                },
              ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  fontSize: 15.0.sp,
                  color: Colors.white,
                ),
                errorStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.cyanAccent,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'veuillez entrer un email valide';
                }
                return null;
              },
              onSaved: (value) {
                emailController.text = value!;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 15.0.sp,
                  color: Colors.white,
                ),
                errorStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.cyanAccent,
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'votre mot de passe doit avoir 6 caractères au minimum';
                }
                return null;
              },
              onSaved: (value) {
                passwordController.text = value!;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: _submitForm,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.sp)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2.sp, 4.sp),
              blurRadius: 5.sp,
              spreadRadius: 2.sp,
            )
          ],
          gradient: LinearGradient(
            colors: [Color(0xffd1abbd), Color(0xffb5487e)],
          ),
        ),
        child: Text(
          'Connecte',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return SizedBox(
      width: 330.w,
      child: InkWell(
        onTap: () {
          _switchAuthMode();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.sp),
          //    padding: EdgeInsets.all(15.sp),
          alignment: Alignment.bottomCenter,
          child: Text(
            _authMode == AuthMode.login
                ? "vous n'avez pas de compte ? cree un"
                : 'vous avez un compte ? ce connecte',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ), // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       _authMode == AuthMode.login
          //           ? "vous n'avez pas de compte ? "
          //           : 'vous avez un compte ? ',
          //       overflow: TextOverflow.ellipsis,
          //       style: TextStyle(
          //         fontSize: 15.sp,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 8.w,
          //     ),
          //     Text(
          //       _authMode == AuthMode.login ? ' cree un' : ' ce connecte',
          //       style: TextStyle(
          //         color: Colors.green,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'MED',
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          //color: Color(0xffb5487e),
          color: Colors.red,
        ),
        children: [
          TextSpan(
            text: 'QUIZZ',
            style: TextStyle(
              //color: Color(0xffb5487e),
              color: Colors.green,
              fontSize: 28.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height.h;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login-background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 120.h),
                  _title(),
                  SizedBox(height: 50.h),
                  _entryField(),
                  SizedBox(height: 20.h),
                  if (_isLoading == true)
                    CircularProgressIndicator()
                  else
                    _submitButton(),
                  SizedBox(height: 10.h),
                  if (_authMode == AuthMode.login)
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'mot de passe oublie ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: height.h * .025,
                  ),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
