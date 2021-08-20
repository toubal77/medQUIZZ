import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110.w,
          height: 110.h,
          margin: EdgeInsets.only(top: 25.sp, bottom: 20.sp),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/profile_doctor.jpeg'),
              fit: BoxFit.cover,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60.sp),
          ),
        ),
        Text(
          'toubal zine eddine',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          'toubalzineddine77@gmail.com',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
