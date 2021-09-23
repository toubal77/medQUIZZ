import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/screens/scores/widgets/build_card_score.dart';
import 'package:med_quizz/screens/scores/widgets/header.dart';
import 'package:med_quizz/screens/scores/widgets/shimmer_card_score.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/services/auth.dart';
import 'package:med_quizz/utils.dart';

class AllScores extends StatefulWidget {
  const AllScores({Key? key}) : super(key: key);

  @override
  _AllScoresState createState() => _AllScoresState();
}

class _AllScoresState extends State<AllScores> {
  final DateTime? currentTime = DateTime.now();
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          Utils.checkConnexion(context);
        } else {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: AdManager.loading == false ? 60.h : 0.h,
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
              Header(),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('scores')
                      .doc(AuthService().getUserId)
                      .collection('modules')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            int.parse(snapshot.data.docs.length.toString()),
                        itemBuilder: (context, index) {
                          return int.parse(
                                    snapshot.data.docs.length.toString(),
                                  ) >
                                  0
                              ? BuildCardScore(
                                  snapshot.data.docs[index],
                                  true,
                                )
                              : SizedBox(
                                  height: 30,
                                  child: Center(child: Text('empty')),
                                );
                        },
                      );
                    }
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
