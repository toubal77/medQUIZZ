import 'package:flutter/material.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/screens/quizz/widgets/option_tile.dart';

class QuizPlayTile extends StatefulWidget {
  final Questions? questionModel;
  final int index;

  const QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
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
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1}: ${widget.questionModel!.question}",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              checkValue1 = !checkValue1;
              if (checkValue1) {
                ///correct
                if (widget.questionModel!.respo1 ==
                    widget.questionModel!.respo1) {
                  setState(() {
                    optionSelected = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel!.rep1;
                    //  widget.questionModel!.respo1 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A",
              answer: widget.questionModel!.rep1,
              correctAnswer:
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  widget.questionModel!.respo1 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              checkValue2 = !checkValue2;
              if (checkValue2) {
                ///correct
                if (widget.questionModel!.respo2 ==
                    widget.questionModel!.respo2) {
                  setState(() {
                    optionSelected = widget.questionModel!.rep2;
                    // widget.questionModel!.respo2 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel!.rep2;
                    // widget.questionModel!.respo2 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "B",
              answer: widget.questionModel!.rep2,
              correctAnswer:
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  widget.questionModel!.respo2 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              checkValue3 = !checkValue3;
              if (checkValue3) {
                ///correct
                if (widget.questionModel!.respo3 ==
                    widget.questionModel!.respo3) {
                  setState(() {
                    optionSelected = widget.questionModel!.rep3;
                    // widget.questionModel!.respo3 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel!.rep3;
                    // widget.questionModel!.respo3 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "C",
              answer: widget.questionModel!.rep3,
              correctAnswer:
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  widget.questionModel!.respo3 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              checkValue4 = !checkValue4;
              if (checkValue4) {
                ///correct
                if (widget.questionModel!.respo4 ==
                    widget.questionModel!.respo4) {
                  setState(() {
                    optionSelected = widget.questionModel!.rep4;
                    // widget.questionModel!.respo4 = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel!.rep4;
                    // widget.questionModel!.respo4 = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "D",
              answer: widget.questionModel!.rep4,
              correctAnswer:
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  widget.questionModel!.respo4 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          if (widget.questionModel!.rep5 != 'null')
            SizedBox(
              height: 4,
              child: Divider(
                height: 3,
                color: Colors.grey,
              ),
            ),
          if (widget.questionModel!.rep5 != 'null')
            GestureDetector(
              onTap: () {
                checkValue5 = !checkValue5;
                if (checkValue5) {
                  ///correct
                  if (widget.questionModel!.respo5 == 'true') {
                    setState(() {
                      optionSelected = widget.questionModel!.rep5;
                      // widget.questionModel!.respo4 = true;
                      _correct = _correct + 1;
                      _notAttempted = _notAttempted + 1;
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel!.rep5;
                      // widget.questionModel!.respo4 = true;
                      _incorrect = _incorrect + 1;
                      _notAttempted = _notAttempted - 1;
                    });
                  }
                }
              },
              child: OptionTile(
                option: "E",
                answer: widget.questionModel!.rep5,
                correctAnswer:
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    widget.questionModel!.respo5 == 'true' ? true : false,
                optionSelected: optionSelected,
              ),
            ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
