import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/view/other/ads/ad_helper.dart';

class BannerAdsWidget extends StatefulWidget {
  double height = -1;
  double weight = -1;

   BannerAdsWidget({super.key, double height = -1, double weight = -1});

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
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
          width: widget.weight>0?widget.weight:banner.size.width.toDouble(),
          height: widget.height>0?widget.height:banner.size.height.toDouble(),
          child: AdWidget(ad: banner),
        ));
  }
}
