import 'package:flutter/material.dart';
import 'package:med_quizz/screens/auth/bezierContainer.dart';
import 'package:med_quizz/screens/auth/bezierContainer2.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  var _isLoading = false;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  Widget _entryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_authMode == AuthMode.Signup)
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'votre nom est trop court';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'veuillez entrer un email valide';
                }
                return null;
              },
              onSaved: (value) {},
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'votre mot de passe doit avoir 6 caractères au minimum';
                }
                return null;
              },
              onSaved: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xffd1abbd), Color(0xffb5487e)],
          ),
        ),
        child: Text(
          'Connecte',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        _switchAuthMode();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _authMode == AuthMode.Login
                  ? 'vous n\'avez pas de compte ?'
                  : 'vous avez un compte ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              _authMode == AuthMode.Login ? 'cree un' : 'ce connecte',
              style: TextStyle(
                color: Color(0xffb5487e),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
          fontSize: 28,
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
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer(),
                  ),
                  Positioned(
                    bottom: -height * .15,
                    left: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer2(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          _title(),
                          SizedBox(height: 50),
                          _entryField(),
                          if (_authMode == AuthMode.Login) SizedBox(height: 20),
                          _isLoading
                              ? CircularProgressIndicator()
                              : _submitButton(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: Text(
                                'mot de passe oublie ?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .040,
                          ),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
