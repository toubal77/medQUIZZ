import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/models/diagnostics.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile.dart';
import 'package:med_quizz/screens/diagnostics/widgets/diag_tile_shimmer.dart';
import 'package:med_quizz/screens/diagnostics/widgets/header_diag.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/services/database.dart';
import 'package:med_quizz/utils.dart';

class Diagnostic extends StatefulWidget {
  const Diagnostic({Key? key}) : super(key: key);
  static const screenName = "Diagnostic";

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
    AdManager.buildInterAd(1);
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
      bottomNavigationBar: SizedBox(
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login-background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const HeaderDiag(title: 'Diagnostics'),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: SizedBox(
                  //  margin: EdgeInsets.only(bottom: 10.sp),
                  child: FutureBuilder<List<Diagnostics?>?>(
                    future: DatabaseMethods().getDiag(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          //    physics: NeverScrollableScrollPhysics(),

                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return DiagTile(diag: snapshot.data![index]!);
                          },
                        );
                      }
                      return const DiagTileShimmer();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
