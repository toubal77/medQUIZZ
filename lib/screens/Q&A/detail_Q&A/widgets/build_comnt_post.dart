import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_image_user.dart';

class BuildCommentePost extends StatelessWidget {
  final comnt;
  BuildCommentePost(this.comnt);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      padding: EdgeInsets.all(7.sp),
      child: Row(
        children: [
          BuildImageUser(),
          SizedBox(
            width: 7.w,
          ),
          Container(
            width: MediaQuery.of(context).size.width.w * 0.6,
            margin: EdgeInsets.only(top: 7.sp, bottom: 7.sp, right: 7.sp),
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comnt['username'],
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  comnt['message'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
