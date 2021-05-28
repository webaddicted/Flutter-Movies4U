  import 'package:movies4u/utils/sp/sp_manager.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeModel extends Model {
   bool isDarkTheme = false;
  static bool dark = false;

  bool get getTheme => isDarkTheme;

  void setTheme(bool isDarkThem) async {
    this.isDarkTheme = isDarkThem;
    dark = isDarkThem;
    print("value theemememe ;  $isDarkThem");
    await SPManager.setThemeDark(isDarkThem);
    notifyListeners();
  }
}

