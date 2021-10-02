import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/home_screen.dart';
import 'package:med_quizz/screens/quizz/components/progress_bar.dart';
import 'package:med_quizz/screens/quizz/score_quizz_screen.dart';
import 'package:med_quizz/screens/quizz/widgets/quiz_play_tile.dart';
import 'package:med_quizz/services/database.dart';
import 'package:med_quizz/utils.dart';

int correct = 0;
int incorrect = 0;

class QuizzPlay extends StatefulWidget {
  final String title;
  const QuizzPlay({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _QuizzPlayState createState() => _QuizzPlayState();
}

bool validate = false;

class _QuizzPlayState extends State<QuizzPlay> {
  bool timeOver = false;
  late StreamSubscription subscription;
  @override
  void initState() {
    Calculate.restart();
    subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          Utils.checkConnexion(context);
        } else {
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (timeOver == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 80.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TIME OVER',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'voulez vous voir la corrections des questions ? ',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 45.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ),
                              );
                            },
                            child: const Text('non'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        height: 45.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                validate = true;
                                Navigator.of(context).pop();
                              });
                            },
                            child: const Text("oui"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login-background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                validate = false;
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: Text(
                                'QCM',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: quizList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: validate == false
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 115.h,
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'triste',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Êtes-vous sûr de valide le qcm avant que le temps se termine ?',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  height: 45.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annule'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.w,
                                  height: 45.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          validate = true;
                                        });
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ScoreQuizzScreen(
                                                title: widget.title,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text("confirmer"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.coronavirus),
            )
          : Container(),
    );
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
      child: Column(
        children: [
          FutureBuilder<List<Questions?>?>(
            future: DatabaseMethods().getQuestions(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height.h * 0.4,
                          ),
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Text('Chargement...'),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ProgressBar(
                              timeOver: timeOver, title: widget.title),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return QuizPlayTile(
                              questionModel: snapshot.data![index],
                              index: index,
                              validate: validate,
                            );
                          },
                        ),
                      ],
                    );
            },
          )
        ],
      ),
    );
  }
}

class Calculate {
  static void onChnageCorrect() {
    correct += 1;
    // ignore: avoid_print
    print('correct ${correct.toString()}');
  }

  static void onChnageIncorrect() {
    incorrect += 1;
    // ignore: avoid_print
    print('incorrect ${incorrect.toString()}');
  }

  static void restart() {
    correct = 0;
    incorrect = 0;
  }

  static int get correctTotal {
    // ignore: avoid_print
    print('correct total ${correct.toString()}');
    return correct;
  }

  static int get incorrectTotal {
    // ignore: avoid_print
    print('incorrect total ${correct.toString()}');
    return incorrect;
  }
}
