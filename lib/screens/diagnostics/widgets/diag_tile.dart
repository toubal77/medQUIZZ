import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/screens/diagnostics/detail_Diag/detail_diag.dart';

class DiagTile extends StatelessWidget {
  final Diagnostics diag;
  const DiagTile({
    Key? key,
    required this.diag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailDiag(diag: diag);
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width.w,
        height: 310.h,
        margin: EdgeInsets.only(right: 20.sp, left: 20.sp, bottom: 20.sp),
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
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://rayanzinotblans.000webhostapp.com/images/diagnostics/${diag.image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.sp),
                    bottomRight: Radius.circular(30.sp),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diag.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      diag.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
