import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8691691433";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
     }
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void loadBannerAd(){
    _bannerAd =BannerAd(
      adUnitId:  bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    _bannerAd?.load();
  }
 // create interstitial ads
  void loadInterstitialAd(){
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad){
          //Keep a reference to the ad so you can show it later
          _interstitialAd=ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error){
          print('InterstitialAd failed to load: $error');
        },
      )
      );
  }
  void adAds(bool interstitial ,bool bannerAd){
    if(interstitial){
      loadInterstitialAd();
    }
    if(bannerAd){
      loadBannerAd();
    }

  }
  void showInterstitialAd(){
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      loadInterstitialAd();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }

  BannerAd? getBannerAd(){
    return _bannerAd;
  }
  void disposeAd(){
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    // _bannerAd=null;
  }
}