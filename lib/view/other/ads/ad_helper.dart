import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-8313390713451107/4262303003';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8313390713451107/4262303003';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8313390713451107/4546756927";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8313390713451107/4546756927";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
  static String get rewardedInterstitialAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/5354046379';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8313390713451107/5501827515";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8313390713451107/5501827515";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8313390713451107/1729021895";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8313390713451107/1729021895";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
  static String get nativeAdvanceAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8313390713451107/5476695217";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8313390713451107/5476695217";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
  static String get appOpenAdUnitId {
    if(kDebugMode) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else if (Platform.isAndroid) {
      return "ca-app-pub-8313390713451107/3610161347";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8313390713451107/3610161347";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
  // App Open	ca-app-pub-3940256099942544/3419835294
  // Adaptive Banner	ca-app-pub-3940256099942544/9214589741
  // Banner	ca-app-pub-3940256099942544/6300978111
  // Interstitial	ca-app-pub-3940256099942544/1033173712
  // Interstitial Video	ca-app-pub-3940256099942544/8691691433
  // Rewarded	ca-app-pub-3940256099942544/5224354917
  // Rewarded Interstitial	ca-app-pub-3940256099942544/5354046379
  // Native Advanced	ca-app-pub-3940256099942544/2247696110
  // Native Advanced Video	ca-app-pub-3940256099942544/1044960115
}