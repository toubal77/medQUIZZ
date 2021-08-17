import 'package:flutter/material.dart';
import 'package:med_quizz/screens/diagnostics/widgets/header_diag.dart';

class Diagnostics extends StatelessWidget {
  const Diagnostics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderDiag(title: 'Diagnostics'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
