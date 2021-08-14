import 'package:shared_preferences/shared_preferences.dart';

class SPHelper<T> {
  static Future<T> getPreference<T>(String key, T defautlValue) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      if (defautlValue is String) {
        return sp.getString(key) as T;
      } else if (defautlValue is bool) {
        return sp.getBool(key) as T;
      } else if (defautlValue is int) {
        return sp.getInt(key) as T;
      } else if (defautlValue is double) {
        return sp.getDouble(key) as T;
      } else if (defautlValue is List<String>) {
        return sp.getDouble(key) as T;
      }
    } catch (e) {
      print("SP helper : "+e.toString());
    }
    return 0 as T;
  }

  static Future<bool> setPreference<T>(String key, T value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      if (value is String) {
        return sp.setString(key, value);
      } else if (value is bool) {
        return sp.setBool(key, value);
      } else if (value is int) {
        return sp.setInt(key, value);
      } else if (value is double) {
        return sp.setDouble(key, value);
      } else if (value is double) {
        return sp.setDouble(key, value);
      } else if (value is List<String>) {
        return sp.setStringList(key, value);
      }
    } catch (e) {
      print("SP helper : "+e.toString());
    }
    return false;
  }

  static Future<Set<String>> getAllKeys() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      return sp.getKeys();
    } catch (e) {
      print("SP helper : "+e.toString());
      return null!;
    }
  }

  static Future<bool> removeKey(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      return sp.remove(key);
    } catch (e) {
      print("SP helper : "+e.toString());
      return false;
    }
  }

  static Future<bool> clearPreference() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      return sp.clear();
    } catch (e) {
      print("SP helper : "+e.toString());
      return false;
    }
  }

  static Future<bool> keyExist(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      return sp.containsKey(key);
    } catch (e) {
      print("SP helper : "+e.toString());
      return false;
    }
  }
}
