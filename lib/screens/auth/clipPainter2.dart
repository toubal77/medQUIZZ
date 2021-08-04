import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ClipPainter2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(size.height, 0);
    path.lineTo(height, size.width);
    path.lineTo(0, size.width);

    /// [Top Left corner]
    var secondControlPoint = Offset(3, 3);
    var secondEndPoint = Offset(height * .4, width * .5);
    path.quadraticBezierTo(secondControlPoint.dy, secondControlPoint.dx,
        secondEndPoint.dy, secondEndPoint.dx);

    /// [Left Middle]
    var fifthControlPoint = Offset(height * .1, width * .7);
    var fiftEndPoint = Offset(width * .37, height * .9);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fiftEndPoint.dy, fiftEndPoint.dx);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(height, 0);
    var thirdEndPoint = Offset(height, width * 2);
    path.quadraticBezierTo(thirdControlPoint.dy, thirdControlPoint.dx,
        thirdEndPoint.dy, thirdEndPoint.dx);

    path.lineTo(size.height * 2, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
