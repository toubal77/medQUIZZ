import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get bannerAdUnitId => 'ca-app-pub-7410810465692328/1352017336';
  static String get interstitialId => 'ca-app-pub-7410810465692328/1853400580';
  static bool loading = false;
  static Future<void> buildInterAd(int minDure) {
    return InterstitialAd.load(
      adUnitId: AdManager.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          Timer(Duration(seconds: minDure), () => ad.show());
        },
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static BannerAd buildBannerAd() {
    final BannerAd ad = BannerAd(
      // adUnitId: 'ca-app-pub-7410810465692328/1352017336',
      size: AdSize.fullBanner,
      adUnitId: bannerAdUnitId,

      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // ignore: avoid_print
          print('On Ad Loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          loading = true;
          // ignore: avoid_print
          print(
            'error ad load:${error.code} ${error.message} ${error.domain} ${error.responseInfo}',
          );
          ad.dispose();
        },
        onAdClosed: (Ad ad) {
          loading = true;
          // ignore: avoid_print
          print('On Ad Closed');
        },
      ),
      request: const AdRequest(),
    );
    return ad;
  }
}
