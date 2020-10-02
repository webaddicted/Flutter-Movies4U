import 'package:Moviesfree4U/utils/sp/sp_manager.dart';
import 'package:scoped_model/scoped_model.dart';
class ThemeModel extends Model {
  bool isDarkTheme = false;
  bool get getTheme => isDarkTheme;
  void setTheme(bool isDarkTheme) async {
    this.isDarkTheme = isDarkTheme;
    await SPManager.setThemeDark(isDarkTheme);
    notifyListeners();
  }
}
