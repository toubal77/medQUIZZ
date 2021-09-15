import 'package:flutter/material.dart';

class ScoreQuizzScreen extends StatelessWidget {
  final int correct;
  final int incorrect;
  final int total;
  ScoreQuizzScreen(this.correct, this.incorrect, this.total);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sCORE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('coucoucouc'),
            Text('correct: ${correct.toString()}'),
            Text('incorrect: ${incorrect.toString()}'),
            Text('total: ${total.toString()}'),
          ],
        ),
      ),
    );
  }
}
