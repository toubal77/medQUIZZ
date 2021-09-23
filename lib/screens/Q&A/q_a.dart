import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_card_posts.dart';
import 'package:med_quizz/screens/Q&A/widgets/header.dart';
import 'package:med_quizz/screens/Q&A/widgets/shimmer_card_post.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/utils.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({Key? key}) : super(key: key);

  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
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
      bottomNavigationBar: SizedBox(
        height: AdManager.loading == false ? 60.h : 0.h,
        key: UniqueKey(),
        child: AdWidget(
          ad: AdManager.buildBannerAd()..load(),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const Header(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            int.parse(snapshot.data!.docs.length.toString()),
                        itemBuilder: (context, index) {
                          return BuildCardPosts(
                            posts: snapshot.data!.docs[index],
                            idPost: snapshot.data!.docs[index].id.toString(),
                          );
                        },
                      );
                    }
                    return const ShimmerCardPost();
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
