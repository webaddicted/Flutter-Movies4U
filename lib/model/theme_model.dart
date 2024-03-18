  import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/sp/sp_manager.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeModel extends Model {
   bool isDarkTheme = false;
  static bool dark = false;

  bool get getTheme => isDarkTheme;

  void setTheme(bool isDarkThem) async {
    isDarkTheme = isDarkThem;
    dark = isDarkThem;
    printLog(tag: runtimeType.toString(),msg: "value theme:$isDarkThem");
    SPManager.setThemeDark(isDarkThem);
    notifyListeners();
  }
}

