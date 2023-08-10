// ignore_for_file: file_names

import '../../../models/auth_model.dart';
import '../../constants/enum/cache_enum.dart';

abstract class SharedPreferencesService {
  fetchAuth(SharedPreferencesKeys keys);

  deleteAuth(SharedPreferencesKeys keys);

  Future? cacheAuth(AuthModel model);

  cacheBoolean(SharedPreferencesKeys keys, bool rememberMe);

  Future? fetchBoolean(SharedPreferencesKeys keys);
}
