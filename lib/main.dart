import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/screens/Q&A/posts/add_post.dart';
import 'package:med_quizz/screens/auth/login_screen.dart';
import 'package:med_quizz/screens/diagnostics/diagnostics.dart';
import 'package:med_quizz/screens/home_screen.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:overlay_support/overlay_support.dart';

//receive message <hen app is in background
Future<void> backgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print(message.data.toString());
  // ignore: avoid_print
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          routes: {
            Diagnostic.screenName: (context) => const Diagnostic(),
            HomePage.screenName: (context) => HomePage(),
            AddPost.screenName: (context) => const AddPost(),
          },
        ),
      ),
      designSize: const Size(360, 640),
    );
  }
}
