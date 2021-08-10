import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String text;
  HomePage(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
