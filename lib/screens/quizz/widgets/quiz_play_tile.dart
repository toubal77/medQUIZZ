import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/quizz/quizz_screen.dart';
import 'package:med_quizz/screens/quizz/widgets/option_tile.dart';

class QuizPlayTile extends StatefulWidget {
  final Questions? questionModel;
  final int index;
  final bool validate;

  const QuizPlayTile({
    required this.questionModel,
    required this.index,
    required this.validate,
  });

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  @override
  void initState() {
    correctAnswer1 = widget.questionModel!.respo1 == 'true' ? true : false;
    correctAnswer2 = widget.questionModel!.respo2 == 'true' ? true : false;
    correctAnswer3 = widget.questionModel!.respo3 == 'true' ? true : false;
    correctAnswer4 = widget.questionModel!.respo4 == 'true' ? true : false;
    correctAnswer5 = widget.questionModel!.respo5 == 'true' ? true : false;
    super.initState();
  }

  late bool correctAnswer1;
  late bool correctAnswer2;
  late bool correctAnswer3;
  late bool correctAnswer4;
  late bool correctAnswer5;

  String optionSelected1 = "";
  String optionSelected2 = "";
  String optionSelected3 = "";
  String optionSelected4 = "";
  String optionSelected5 = "";

  bool checkValue1 = false;
  bool checkValue2 = false;
  bool checkValue3 = false;
  bool checkValue4 = false;
  bool checkValue5 = false;
  bool checkQuestion5() {
    if (checkValue1 == correctAnswer1 &&
        checkValue2 == correctAnswer2 &&
        checkValue3 == correctAnswer3 &&
        checkValue4 == correctAnswer4 &&
        checkValue5 == correctAnswer5) {
      Calculate.onChnageCorrect();
      return true;
    } else {
      Calculate.onChnageIncorrect();
      return false;
    }
  }

  bool checkQuestion4() {
    if (checkValue1 == correctAnswer1 &&
        checkValue2 == correctAnswer2 &&
        checkValue3 == correctAnswer3 &&
        checkValue4 == correctAnswer4) {
      Calculate.onChnageCorrect();
      return true;
    } else {
      Calculate.onChnageIncorrect();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Text(
              "Q${widget.index + 1}: ${widget.questionModel!.question}",
              style: TextStyle(fontSize: 18.sp, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () {
              if (optionSelected1 == '') {
                ///correct
                if (correctAnswer1) {
                  setState(() {
                    optionSelected1 = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    checkValue1 = true;
                  });
                } else {
                  setState(() {
                    optionSelected1 = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    checkValue1 = false;
                  });
                }
              } else {
                setState(() {
                  optionSelected1 = '';
                });
              }
            },
            child: OptionTile(
              option: "A",
              answer: widget.questionModel!.rep1, // la question
              correctAnswer: correctAnswer1, // la reponse
              optionSelected: optionSelected1, //est ce que ca ete selectionne
              validate: widget.validate,
            ),
          ),
          SizedBox(
            height: 4.h,
            child: Divider(
              height: 3.h,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (optionSelected2 == '') {
                ///correct
                if (correctAnswer2) {
                  setState(() {
                    optionSelected2 = widget.questionModel!.rep2;
                    //  widget.questionModel!.respo1 = true;
                    checkValue2 = true;
                  });
                } else {
                  setState(() {
                    optionSelected2 = widget.questionModel!.rep2;
                    //  widget.questionModel!.respo1 = true;
                    checkValue2 = false;
                  });
                }
              } else {
                setState(() {
                  optionSelected2 = '';
                });
              }
            },
            child: OptionTile(
              option: "B",
              answer: widget.questionModel!.rep2,
              correctAnswer: correctAnswer2,
              optionSelected: optionSelected2,
              validate: widget.validate,
            ),
          ),
          SizedBox(
            height: 4.h,
            child: Divider(
              height: 3.h,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (optionSelected3 == '') {
                ///correct
                if (correctAnswer3) {
                  setState(() {
                    optionSelected3 = widget.questionModel!.rep3;
                    //  widget.questionModel!.respo1 = true;
                    checkValue3 = true;
                  });
                } else {
                  setState(() {
                    optionSelected3 = widget.questionModel!.rep3;
                    //  widget.questionModel!.respo1 = true;
                    checkValue3 = false;
                  });
                }
              } else {
                setState(() {
                  optionSelected3 = '';
                });
              }
            },
            child: OptionTile(
              option: "C",
              answer: widget.questionModel!.rep3,
              correctAnswer: correctAnswer3,
              optionSelected: optionSelected3,
              validate: widget.validate,
            ),
          ),
          SizedBox(
            height: 4.h,
            child: Divider(
              height: 3.h,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (optionSelected4 == '') {
                ///correct
                if (correctAnswer4) {
                  setState(() {
                    optionSelected4 = widget.questionModel!.rep4;
                    //  widget.questionModel!.respo1 = true;
                    checkValue4 = true;
                  });
                } else {
                  setState(() {
                    optionSelected4 = widget.questionModel!.rep4;
                    //  widget.questionModel!.respo1 = true;
                    checkValue4 = false;
                  });
                }
              } else {
                setState(() {
                  optionSelected4 = '';
                });
              }
            },
            child: OptionTile(
              option: "D",
              answer: widget.questionModel!.rep4,
              correctAnswer: correctAnswer4,
              optionSelected: optionSelected4,
              validate: widget.validate,
            ),
          ),
          if (widget.questionModel!.rep5 != 'null')
            SizedBox(
              height: 4.h,
              child: Divider(
                height: 3.h,
                color: Colors.grey,
              ),
            ),
          if (widget.questionModel!.rep5 != 'null')
            GestureDetector(
              onTap: () {
                if (optionSelected5 == '') {
                  ///correct
                  if (correctAnswer5) {
                    setState(() {
                      optionSelected5 = widget.questionModel!.rep5;
                      //  widget.questionModel!.respo1 = true;
                      checkValue5 = true;
                    });
                  } else {
                    setState(() {
                      optionSelected5 = widget.questionModel!.rep5;
                      //  widget.questionModel!.respo1 = true;
                      checkValue5 = false;
                    });
                  }
                } else {
                  setState(() {
                    optionSelected5 = '';
                  });
                }
              },
              child: OptionTile(
                option: "E",
                answer: widget.questionModel!.rep5,
                correctAnswer: correctAnswer5,
                optionSelected: optionSelected5,
                validate: widget.validate,
              ),
            ),
          if (widget.validate)
            Container(
              width: MediaQuery.of(context).size.width.w,
              margin: EdgeInsets.only(bottom: 13.sp, left: 5.sp, right: 5.sp),
              padding: EdgeInsets.only(
                top: 10.sp,
                left: 7.sp,
                right: 7.sp,
                bottom: 7.sp,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.questionModel!.rep5 != 'null'
                        ? checkQuestion5()
                            ? 'Votre reponse est correct'
                            : 'Votre reponse est incorrect'
                        : checkQuestion4()
                            ? 'Votre reponse est correct'
                            : 'Votre reponse est incorrect',
                    style: TextStyle(
                      color: widget.questionModel!.rep5 != 'null'
                          ? checkValue1 == correctAnswer1 &&
                                  checkValue2 == correctAnswer2 &&
                                  checkValue3 == correctAnswer3 &&
                                  checkValue4 == correctAnswer4 &&
                                  checkValue5 == correctAnswer5
                              ? Colors.green
                              : Colors.red
                          : checkValue1 == correctAnswer1 &&
                                  checkValue2 == correctAnswer2 &&
                                  checkValue3 == correctAnswer3 &&
                                  checkValue4 == correctAnswer4
                              ? Colors.green
                              : Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Explication: ${widget.questionModel!.explication}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
