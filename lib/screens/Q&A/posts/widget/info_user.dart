import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7.sp, left: 7.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/profile_doctor.jpeg'),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(60.sp),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.sp, bottom: 7.sp),
            child: Text(
              'toubal zineddine',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
