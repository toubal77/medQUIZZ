import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get bannerAdUnitId => 'ca-app-pub-3940256099942544/6300978111';

  static BannerAd buildBannerAd() {
    BannerAd ad = new BannerAd(
      // adUnitId: 'ca-app-pub-7410810465692328/1352017336',
      size: AdSize.fullBanner,
      adUnitId: bannerAdUnitId,

      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('On Ad Loaded'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('On Ad Opened'),
        onAdClosed: (Ad ad) => print('On Ad Closed'),
      ),
      request: AdRequest(),
    );
    return ad;
  }
}
