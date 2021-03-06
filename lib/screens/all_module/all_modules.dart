import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:med_quizz/models/modules.dart';
import 'package:med_quizz/screens/all_module/widgets/header_all_module.dart';
import 'package:med_quizz/screens/all_module/widgets/module_tile.dart';
import 'package:med_quizz/screens/all_module/widgets/shimmer_module_tile.dart';
import 'package:med_quizz/services/ads_service.dart';
import 'package:med_quizz/services/database.dart';
import 'package:med_quizz/utils.dart';

class AllModules extends StatefulWidget {
  const AllModules({Key? key}) : super(key: key);

  @override
  _AllModulesState createState() => _AllModulesState();
}

class _AllModulesState extends State<AllModules> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderAllModule(),
              Container(
                height: 30.h,
                margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Center(
                  child: FutureBuilder<String?>(
                    future: DatabaseMethods().getYearsUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString() == '1'
                              ? 'premi??re ann??e'
                              : '${snapshot.data.toString()} ere ann??e medecine',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Modules?>?>(
                  future: DatabaseMethods().getModules(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ModuleTile(mod: snapshot.data![index]);
                        },
                      );
                    }
                    return const ModuleTileShimmer();
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
