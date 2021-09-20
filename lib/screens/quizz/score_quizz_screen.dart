import 'dart:async';
import 'package:flutter/material.dart';
import 'package:med_quizz/screens/quizz/quizz_screen.dart';

class ScoreQuizzScreen extends StatefulWidget {
  @override
  State<ScoreQuizzScreen> createState() => _ScoreQuizzScreenState();
}

class _ScoreQuizzScreenState extends State<ScoreQuizzScreen> {
  bool loading = true;
  @override
  void initState() {
    Timer(
      Duration(milliseconds: 700),
      () {
        setState(() => loading = false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sCORE'),
      ),
      body: !loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('coucoucouc'),
                  Text('correct: ${Calculate.correctTotal.toString()}'),
                  Text('incorrect: ${Calculate.incorrectTotal.toString()}'),
                  Text('total: 20'),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
