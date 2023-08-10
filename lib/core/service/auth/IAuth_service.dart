// ignore_for_file: file_names



import '../../../models/auth_model.dart';
import '../../../models/login_response.dart';

abstract class FirebaseAuthService {

  Future<LoginResponseModel> authLogin(AuthModel model);


}
