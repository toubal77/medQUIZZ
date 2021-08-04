import 'dart:math';
import 'package:flutter/material.dart';
import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi * log(1000) / 3,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffd1abbd), Color(0xffb5487e)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
