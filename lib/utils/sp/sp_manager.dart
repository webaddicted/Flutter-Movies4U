import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/sp/sp_helper.dart';

class SPManager {
  static void setOnboarding<T>(bool isOnBoardingShow) {
    SPHelper.setPreference(StringConst.isOnBoardingShow, isOnBoardingShow);
  }

  static Future<bool> getOnboarding<T>() async {
    var spValue =
        await SPHelper.getPreference(StringConst.isOnBoardingShow, false);
    return spValue;
  }

  static String setThemeDark<T>(bool isThemeDark) {
    SPHelper.setPreference(StringConst.isThemeDark, isThemeDark);
    return "";
  }

  static Future<bool> getThemeDark() async {
    final spValue =
        await SPHelper.getPreference(StringConst.isThemeDark, false);
    return spValue;
  }

  static Future<Set<String>?> getAllKeys() async {
    var spValue = await SPHelper.getAllKeys();
    return spValue;
  }

  static Future<bool> removeKeys() async {
    var spValue = await SPHelper.removeKey(StringConst.isOnBoardingShow);
    return spValue;
  }

  static Future<bool> clearPref() async {
    var spValue = await SPHelper.clearPreference();
    return spValue;
  }
}
