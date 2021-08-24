import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/services/database.dart';
import 'package:shimmer/shimmer.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110.w,
          height: 110.h,
          margin: EdgeInsets.only(top: 25.sp, bottom: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/profile_doctor.jpeg'),
              fit: BoxFit.cover,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60.sp),
          ),
        ),
        FutureBuilder<DocumentSnapshot?>(
          future: DatabaseMethods().getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    snapshot.data!['username'],
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
                    snapshot.data!['email'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    width: 150.w,
                    height: 20.h,
                    margin: const EdgeInsets.only(left: 3),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    width: 150.w,
                    height: 20.h,
                    margin: const EdgeInsets.only(left: 3),
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
