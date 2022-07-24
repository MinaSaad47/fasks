import 'dart:async';

import 'package:cache/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheSharedPref extends Cache {
  final Future<SharedPreferences> _sharedpref;

  CacheSharedPref() : _sharedpref = SharedPreferences.getInstance();

  @override
  Future<T> load<T>(String key) async {
    var sp = await _sharedpref;
    return sp.get(key) as T;
  }

  @override
  Future<bool> save<T>({required String key, required T value}) async {
    bool success = false;
    var sp = await _sharedpref;
    if (T == String) {
      success = await sp.setString(key, value as String);
    } else if (T == bool) {
      success = await sp.setBool(key, value as bool);
    } else if (T == int) {
      success = await sp.setInt(key, value as int);
    } else if (T == double) {
      success = await sp.setDouble(key, value as double);
    }
    return success;
  }

  @override
  Future<bool> remove(String key) async {
    var sp = await _sharedpref;
    return sp.remove(key);
  }
}
