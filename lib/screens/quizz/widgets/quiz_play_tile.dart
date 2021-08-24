import 'package:flutter/material.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/quizz/widgets/option_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _QuizPlayTileState extends State<QuizPlayTile> {
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
              style: TextStyle(fontSize: 18.sp, color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () {
              if (optionSelected1 == '') {
                ///correct
                if (widget.questionModel!.respo1 == 'true') {
                  setState(() {
                    optionSelected1 = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected1 = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
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
              correctAnswer: widget.questionModel!.respo1 == 'true'
                  ? true
                  : false, // la reponse
              optionSelected: optionSelected1, //est ce que ca ete selectione
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
                if (widget.questionModel!.respo2 == 'true') {
                  setState(() {
                    optionSelected2 = widget.questionModel!.rep2;
                    //  widget.questionModel!.respo1 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected2 = widget.questionModel!.rep2;
                    //  widget.questionModel!.respo1 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
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
              correctAnswer:
                  widget.questionModel!.respo2 == 'true' ? true : false,
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
                if (widget.questionModel!.respo3 == 'true') {
                  setState(() {
                    optionSelected3 = widget.questionModel!.rep3;
                    //  widget.questionModel!.respo1 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected3 = widget.questionModel!.rep3;
                    //  widget.questionModel!.respo1 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
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
              correctAnswer:
                  widget.questionModel!.respo3 == 'true' ? true : false,
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
                if (widget.questionModel!.respo4 == 'true') {
                  setState(() {
                    optionSelected4 = widget.questionModel!.rep4;
                    //  widget.questionModel!.respo1 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected4 = widget.questionModel!.rep4;
                    //  widget.questionModel!.respo1 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
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
              correctAnswer:
                  widget.questionModel!.respo4 == 'true' ? true : false,
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
                  if (widget.questionModel!.respo5 == 'true') {
                    setState(() {
                      optionSelected5 = widget.questionModel!.rep5;
                      //  widget.questionModel!.respo1 = true;
                      _correct = _correct + 1;
                      _notAttempted = _notAttempted + 1;
                    });
                  } else {
                    setState(() {
                      optionSelected5 = widget.questionModel!.rep5;
                      //  widget.questionModel!.respo1 = true;
                      _incorrect = _incorrect + 1;
                      _notAttempted = _notAttempted - 1;
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
                correctAnswer:
                    widget.questionModel!.respo5 == 'true' ? true : false,
                optionSelected: optionSelected5,
                validate: widget.validate,
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
