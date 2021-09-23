import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DiagTileShimmer extends StatelessWidget {
  const DiagTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey.shade300,
            child: Container(
              margin: EdgeInsets.only(bottom: 20.sp),
              width: MediaQuery.of(context).size.width.w,
              height: 300.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.2.sp),
                    spreadRadius: 1.sp,
                    blurRadius: 4.sp,
                    offset: Offset(0.7.sp, 0.7.sp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
