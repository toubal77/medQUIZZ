import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/screens/Q&A/widgets/build_card_posts.dart';
import 'package:med_quizz/screens/Q&A/widgets/header.dart';
import 'package:med_quizz/screens/Q&A/widgets/shimmer_card_post.dart';
import 'package:med_quizz/utils.dart';

enum FilterOptions {
  reportthispost,
}

class QAScreen extends StatefulWidget {
  const QAScreen({Key? key}) : super(key: key);

  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  final DateTime? currentTime = new DateTime.now();
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
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Header(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData)
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return BuildCardPosts(snapshot.data!.docs[index],
                              snapshot.data!.docs[index].id);
                        },
                      );
                    return ShimmerCardPost();
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
