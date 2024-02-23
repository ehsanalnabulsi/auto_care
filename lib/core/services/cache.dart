import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefInstance;

  static Future<void> init() async {
    _prefInstance = await SharedPreferences.getInstance();
  }

  static bool? getBoolean({required String key}) {
    if (_prefInstance != null) {
      return _prefInstance!.getBool(key);
    } else {
      return null; // Or return a default value
    }
  }

  static String? getString({required String key}) {
    if (_prefInstance != null) {
      return _prefInstance!.getString(key);
    } else {
      return null; // Or return a default value
    }
  }

  // ... other methods for specific data types

  static Future<bool> setString(
      {required String key, required String value}) async {
    if (_prefInstance != null) {
      try {
        return await _prefInstance!.setString(key, value);
      } catch (error) {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> setBoolean(
      {required String key, required bool value}) async {
    try {
      return await _prefInstance!.setBool(key, value);
    } catch (error) {
      return false;
    }
  }

  // ... other methods for setting data

  static Future<bool> remove({required String key}) async {
    try {
      return await _prefInstance!.remove(key);
    } catch (error) {
      return false;
    }
  }
}
