import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/enum/cache_enum.dart';
import 'package:stock_app/core/service/cache/shared_cache.dart';
import 'package:stock_app/models/auth_model.dart';

class RiverpodCache extends ChangeNotifier {


  final localInstance = LocalManagement.instance;

  Future cacheAuth(AuthModel model) async {
    return await localInstance.cacheAuth(model);
  }

  fetchAuth(SharedPreferencesKeys keys) {
    return localInstance.fetchAuth(keys);
  }

  deleteAuth(SharedPreferencesKeys keys) {
    return localInstance.deleteAuth(keys);
  }

  Future cacheRememberMe(SharedPreferencesKeys keys, bool rememberMe) async {
    return await localInstance.cacheBoolean(keys, rememberMe);
  }

  Future<bool?>? fetchRememberMe(SharedPreferencesKeys keys) async {
    return await localInstance.fetchBoolean(keys);
  }


}

final cacheProvider = ChangeNotifierProvider<RiverpodCache>((ref) {
  return RiverpodCache();
});
