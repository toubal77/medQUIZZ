import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile_shimmer.dart';
import 'package:med_quizz/screens/diagnostics/widgets/header_diag.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/services/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_quizz/utils.dart';

class Diagnostic extends StatefulWidget {
  const Diagnostic({Key? key}) : super(key: key);
  static final screenName = "\Diagnostic";

  @override
  _DiagnosticState createState() => _DiagnosticState();
}

class _DiagnosticState extends State<Diagnostic> {
  late StreamSubscription subscription;
  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          Utils.checkConnexion(context);
        } else {
          setState(() {});
        }
      },
    );
    super.initState();
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
              image: AssetImage('assets/images/background_page.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              HeaderDiag(title: 'Diagnostics'),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60.sp),
                child: FutureBuilder<List<Diagnostics?>?>(
                  future: DatabaseMethods().getDiag(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        //    physics: NeverScrollableScrollPhysics(),

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return DiagTile(snapshot.data![index]!);
                        },
                      );
                    }
                    return DiagTileShimmer();
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
