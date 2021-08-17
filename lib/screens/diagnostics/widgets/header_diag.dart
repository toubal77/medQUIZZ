import 'package:flutter/material.dart';

class HeaderDiag extends StatelessWidget {
  final String? title;
  HeaderDiag({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
            Center(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
