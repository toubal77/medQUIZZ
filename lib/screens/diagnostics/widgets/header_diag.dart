import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderDiag extends StatelessWidget {
  final String? title;
  const HeaderDiag({required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Container(
        margin: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
              ),
            ),
            Center(
              child: Text(
                //    title!.substring(0, 25) + ' ...',
                title!, textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
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
