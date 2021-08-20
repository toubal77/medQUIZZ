import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/auth/login_screen.dart';
import 'package:med_quizz/screens/home_screen.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:med_quizz/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'med QUIZZ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: AuthService().onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;

              if (user == null) {
                return LoginScreen();
              } else {
                return HomePage();
              }
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
      designSize: const Size(360, 640),
    );
  }
}
