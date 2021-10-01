import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:med_quizz/screens/quizz/quizz_screen.dart';
import 'package:med_quizz/services/database.dart';

class ScoreQuizzScreen extends StatefulWidget {
  final String title;
  const ScoreQuizzScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  State<ScoreQuizzScreen> createState() => _ScoreQuizzScreenState();
}

class _ScoreQuizzScreenState extends State<ScoreQuizzScreen> {
  bool loading = true;
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 700),
      () {
        setState(() {
          loading = false;
          DatabaseMethods().sendScore(
            Calculate.correctTotal.toString(),
            Calculate.incorrectTotal.toString(),
            widget.title,
          );
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !loading
          ? SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login-background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 4,
                      bottom: 8,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          alignment: Alignment.topCenter,
                          child: const Text(
                            'Résultats de mon quizz',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width.w,
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 230.h,
                          // decoration: const BoxDecoration(
                          //   color: Colors.transparent,
                          //   image: DecorationImage(
                          //     image: AssetImage('assets/images/Winners-rafiki.svg'),
                          //     fit: BoxFit.cover,
                          //   ),
                          child: SvgPicture.asset(
                              'assets/images/Winners-rafiki.svg'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(
                                        Icons.home_repair_service_rounded,
                                        color: Colors.red,
                                        size: 70,
                                      ),
                                      Text(
                                        '${Calculate.correctTotal.toString()}/10',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: Container(
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(
                                        Icons.timelapse,
                                        size: 70,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '45 S',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 7,
                            bottom: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Correct',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${Calculate.correctTotal.toString()}/10',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 7,
                            bottom: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Incorrect',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${Calculate.incorrectTotal.toString()}/10',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width.w * 0.5,
                          height: 40.h,
                          margin: const EdgeInsets.only(top: 15),
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Calculate.restart();
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text(
                                'Retour',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
