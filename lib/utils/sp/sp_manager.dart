import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/sp/sp_helper.dart';

class SPManager {
    static void setOnboarding<T>(bool isOnBoardingShow) {
      SPHelper.setPreference(StringConst.IS_ON_BOARDING_SHOW, isOnBoardingShow);
    }

    static Future<bool> getOnboarding<T>() async {
      var spValue =  await SPHelper.getPreference(StringConst.IS_ON_BOARDING_SHOW, false);
      return spValue;
    }

  static String setThemeDark<T>(bool isThemeDark) {
    SPHelper.setPreference(StringConst.IS_THEME_DARK, isThemeDark);
  return "";
    }

  static Future<bool> getThemeDark() async {
    final spValue =  await SPHelper.getPreference(StringConst.IS_THEME_DARK, false);
    return spValue;
  }



  static Future<Set<String>> getAllKeys() async {
    var spValue = await SPHelper.getAllKeys();
    return spValue ;
  }

  static Future<bool> removeKeys() async {
    var spValue = await SPHelper.removeKey(StringConst.IS_ON_BOARDING_SHOW);
    return spValue;
  }

  static Future<bool> clearPref() async {
    var spValue = await SPHelper.clearPreference();
    return spValue;
  }
}
