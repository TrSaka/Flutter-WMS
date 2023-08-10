import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/core/constants/enum/cache_enum.dart';
import 'package:stock_app/core/service/cache/Ishared_cache.dart';

import '../../../models/auth_model.dart';

class LocalManagement extends SharedPreferencesService {
  LocalManagement._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  final _jsonString = '{"status": false, "extra": null}';

  static final LocalManagement _instance = LocalManagement._init();

  SharedPreferences? _preferences;
  static LocalManagement get instance => _instance;

  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  @override
  Future? cacheAuth(AuthModel model) async {
    return await _preferences!.setString(
      SharedPreferencesKeys.CACHE_AUTH.toString(),
      json.encode(model),
    );
  }

  @override
  Future cacheBoolean(SharedPreferencesKeys keys, rememberMe) {
    return _preferences!.setBool(keys.toString(), rememberMe);
  }

  @override
  Future<bool?> fetchBoolean(SharedPreferencesKeys keys) async {
    return _preferences!.getBool(keys.toString());
  }

  @override
  fetchAuth(SharedPreferencesKeys keys) {
    final data =
        json.decode(_preferences!.getString(keys.toString()) ?? _jsonString);
    if (data['status'] != false) {
      var authData = AuthModel.fromMap(data);
      AuthModel userModel = AuthModel(
        email: authData.email,
        password: authData.password,
      );
      return userModel;
    }
    return null;
  }

  @override
  deleteAuth(SharedPreferencesKeys keys) async {
    return await _preferences!
        .remove(SharedPreferencesKeys.CACHE_AUTH.toString());
  }
}
