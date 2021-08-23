import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get bannerAdUnitId => 'ca-app-pub-7410810465692328/1352017336';
  static bool loading = false;
  static BannerAd buildBannerAd() {
    BannerAd ad = new BannerAd(
      // adUnitId: 'ca-app-pub-7410810465692328/1352017336',
      size: AdSize.fullBanner,
      adUnitId: bannerAdUnitId,

      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('On Ad Loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          loading = true;
          print('error ad load:' +
              error.code.toString() +
              ' ' +
              error.message +
              ' ' +
              error.domain +
              ' ' +
              error.responseInfo.toString());
          ad.dispose();
        },
        onAdClosed: (Ad ad) {
          loading = true;
          print('On Ad Closed');
        },
      ),
      request: AdRequest(),
    );
    return ad;
  }
}
