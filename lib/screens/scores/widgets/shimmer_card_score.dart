import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BuildShimmerCardScore extends StatelessWidget {
  const BuildShimmerCardScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.sp),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 13,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: MediaQuery.of(context).size.width.w,
                height: 45.h,
                margin: EdgeInsets.only(bottom: 15.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.sp),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
