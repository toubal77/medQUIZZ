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
        SizedBox(
          height: 15.h,
        ),
        FutureBuilder<DocumentSnapshot?>(
          future: DatabaseMethods().getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!['username'].toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    snapshot.data!['email'].toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  if (snapshot.data!['years'] != 'null')
                    Text(
                      "annee: ${snapshot.data!['years']} éme année",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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
          height: 15.h,
        ),
      ],
    );
  }
}
