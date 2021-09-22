import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/screens/all_module/widgets/header_module.dart';
import 'package:med_quizz/screens/scores/widgets/shimmer_card_score.dart';
import 'package:med_quizz/screens/quizz/quizz_screen.dart';
import 'package:med_quizz/screens/scores/widgets/build_card_score.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/services/auth.dart';

class ModuleScreen extends StatelessWidget {
  final String title;
  ModuleScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: AdManager.loading == false ? 60.h : 0.h,
        //  padding: EdgeInsets.all(8.sp),
        key: UniqueKey(),
        child: AdWidget(
          ad: AdManager.buildBannerAd()..load(),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Header(
                title: title,
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return QuizzPlay(title);
                      },
                    ),
                  );
                },
                child: Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width.h * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0.2, 0.2),
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 14.h,
                width: MediaQuery.of(context).size.width.w,
                color: Colors.grey.shade500,
                child: Center(
                  child: Text(
                    'Mes scores',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('scores')
                      .doc(AuthService().getUserId)
                      .collection('modules')
                      .where('module', isEqualTo: title.toString())
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData)
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return snapshot.data.docs.length > 0
                                ? BuildCardScore(
                                    snapshot.data.docs[index], false)
                                : Container(
                                    height: 30,
                                    child: Center(child: Text('empty')),
                                  );
                          });
                    return BuildShimmerCardScore();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
