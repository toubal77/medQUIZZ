import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildImageUser extends StatelessWidget {
  const BuildImageUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
