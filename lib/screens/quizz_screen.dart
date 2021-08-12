import 'package:flutter/material.dart';
import 'package:med_quizz/models/questions.dart';
import 'package:med_quizz/services/database.dart';

class QuizzPlay extends StatefulWidget {
  const QuizzPlay({Key? key}) : super(key: key);

  @override
  _QuizzPlayState createState() => _QuizzPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

class _QuizzPlayState extends State<QuizzPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Med QUIZZ'),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: quizList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.coronavirus),
        onPressed: () {},
      ),
    );
  }

  Widget quizList() {
    return Container(
      child: Column(
        children: [
          FutureBuilder<List<Questions?>?>(
            future: DatabaseMethods().getQuestions(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionModel: snapshot.data![index],
                          index: index,
                        );
                      });
            },
          )
        ],
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final Questions? questionModel;
  final int index;

  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1} ${widget.questionModel!.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
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
            },
            child: OptionTile(
              option: "A",
              answer: "${widget.questionModel!.rep1}",
              correctAnswer:
                  widget.questionModel!.respo1 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
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
            },
            child: OptionTile(
              option: "B",
              answer: "${widget.questionModel!.rep2}",
              correctAnswer:
                  widget.questionModel!.respo2 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
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
            },
            child: OptionTile(
              option: "C",
              answer: "${widget.questionModel!.rep3}",
              correctAnswer:
                  widget.questionModel!.respo3 == 'true' ? true : false,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
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
            },
            child: OptionTile(
              option: "D",
              answer: "${widget.questionModel!.rep4}",
              correctAnswer:
                  widget.questionModel!.respo4 == 'true' ? true : false,
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

class OptionTile extends StatefulWidget {
  final String answer, option, optionSelected;
  final bool correctAnswer;
  OptionTile({
    required this.option,
    required this.correctAnswer,
    required this.answer,
    required this.optionSelected,
  });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.optionSelected == widget.answer
                        ? widget.optionSelected == widget.answer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.optionSelected == widget.answer
                    ? widget.optionSelected == widget.answer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.optionSelected == widget.answer
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.answer,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({required this.text, required this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
