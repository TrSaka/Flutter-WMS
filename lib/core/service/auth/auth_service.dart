import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/constants/enum/auth_enum.dart';
import 'package:stock_app/core/service/auth/IAuth_service.dart';

import '../../../models/auth_model.dart';
import '../../../models/login_response.dart';
import '../../extensions/firebase_extension.dart';

class AuthService extends FirebaseAuthService {
  static AuthService? _instance;
  static AuthService? get instance {
    _instance ??= AuthService._init();
    return _instance;
  }

  AuthService._init();

  @override
  Future<LoginResponseModel> authLogin(AuthModel model) async {
    try {
      var response = await FirebaseExtension.firebaseAuth
          .signInWithEmailAndPassword(
              email: model.email, password: model.password);

      if (response.user?.uid != null) {
        return LoginResponseModel(
            message: StringConstants.succesfullyLogin, state: AuthEnum.SUCCESS);
      } else {
        return LoginResponseModel(
            message: StringConstants.authErrorText, state: AuthEnum.FAILED);
      }
    } catch (e) {
      return LoginResponseModel(message: 'Error: $e', state: AuthEnum.FAILED);
    }
  }
}
