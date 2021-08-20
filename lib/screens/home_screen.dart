import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/all_module/all_modules.dart';
import 'package:med_quizz/screens/diagnostics/diagnostics.dart';
import 'package:med_quizz/screens/profile/profile_screen.dart';
import 'package:med_quizz/screens/quizz/quizz_screen.dart';
import 'package:med_quizz/screens/search/search_screen.dart';
import 'package:med_quizz/services/database.dart';
import 'package:med_quizz/services/local_notification.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  static final screenName = "\HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);

    //give the message on which user taps
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
    //forground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });
    //background where user click in notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_page.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SearchScreen();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.search),
                              color: Colors.blue,
                            ),
                            Text(
                              'Med QUIZZ',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProfileScreen();
                                          },
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.account_circle,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bonjour',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 220.w,
                              child: Text(
                                'Doctor toubal zine eddine',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 350.h,
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(8),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 5.sp, bottom: 10.sp, left: 5.sp, right: 5.sp),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(35.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1.sp,
                              blurRadius: 3.sp,
                              offset: Offset(0.3.sp, 0.3.sp),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Icon(
                              Icons.sports_score,
                              size: 70.sp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Mes scores',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Diagnostic();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.sp,
                              bottom: 10.sp,
                              left: 5.sp,
                              right: 5.sp),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(35.sp),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                spreadRadius: 1.sp,
                                blurRadius: 3.sp,
                                offset: Offset(0.3.sp, 0.3.sp),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Icon(
                                Icons.sick,
                                size: 70.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Diagnostics',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AllModules();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5.sp,
                              bottom: 10.sp,
                              left: 5.sp,
                              right: 5.sp),
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(35.sp),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                spreadRadius: 1.sp,
                                blurRadius: 3.sp,
                                offset: Offset(0.3.sp, 0.3.sp),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Icon(
                                Icons.school,
                                size: 70.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Modules',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 5.sp, bottom: 10.sp, left: 5.sp, right: 5.sp),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1.sp,
                              blurRadius: 3.sp,
                              offset: Offset(0.3.sp, 0.3.sp),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Icon(
                              Icons.file_copy,
                              size: 70.sp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Cours & resumes',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Text(
                    'Module Populare',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  height: 270.h,
                  child: FutureBuilder<List<Modules?>?>(
                    future: DatabaseMethods().getModules(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (contex, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return QuizzPlay();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 4, right: 23),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                height: 235.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          width: 315.w,
                                          height: 220.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                'https://rayanzinotblans.000webhostapp.com/images/${snapshot.data![index]!.image}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0.sp, 2.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 10,
                                        //   child: Text(
                                        //     snapshot.data![index]!.nom.toString(),
                                        //     style: TextStyle(
                                        //       fontSize: 23,
                                        //       fontWeight: FontWeight.w800,
                                        //       letterSpacing: -0.33,
                                        //       color: Colors.white,
                                        //     ),
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(top: 4, right: 23),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          height: 235.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey.shade300,
                                child: Container(
                                  width: 315.w,
                                  height: 220.h,
                                  margin: const EdgeInsets.only(
                                      top: 4, right: 23, bottom: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
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
