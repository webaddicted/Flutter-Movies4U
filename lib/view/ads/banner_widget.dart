import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/view/other/ads/ad_helper.dart';

class BannerWidget extends StatefulWidget {
  int height = -1;
  int weight = -1;

   BannerWidget({super.key, int height = -1, int weight = -1});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return getBannerAds();
  }
  Widget getBannerAds() {
    var banner = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
        },
        onAdFailedToLoad: (ad, err) {
          printLog(msg: 'Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );
    banner.load();
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: banner.size.width.toDouble(),
          height: banner.size.height.toDouble(),
          child: AdWidget(ad: banner),
        ));
  }
}
