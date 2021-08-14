import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          margin: EdgeInsets.only(top: 25, bottom: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/profile_doctor.jpeg'),
              fit: BoxFit.cover,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        Text(
          'toubal zine eddine',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'toubalzineddine77@gmail.com',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
