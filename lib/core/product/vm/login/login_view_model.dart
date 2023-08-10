import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/mixins/snackbar_mixin.dart';
import 'package:stock_app/core/product/routes/router.dart';
import '../../../../models/auth_model.dart';
import '../../../../models/login_response.dart';
import '../../../constants/enum/auth_enum.dart';
import '../../../riverpod/firebase_riverpod.dart';

class LoginViewModel with SnackbarMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  void initalizeController() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposeController() {
    emailController.dispose();
    passwordController.dispose();
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }

  Future loginUser(WidgetRef ref, emailController, passwordController) async {
    AuthModel model = AuthModel(
        email: emailController.text, password: passwordController.text);

    return await ref.read(firebaseProvider.notifier).loginUser(model);
  }

  void showSnackB(BuildContext context, LoginResponseModel model) {
    showSnackBar(context, model.message);
  }

  Future interactByAuthState(
      LoginResponseModel model, BuildContext context) async {
    AuthEnum authState = model.state;
    if (authState == AuthEnum.SUCCESS) {
      showSnackB(context, model);
      Future.delayed(const Duration(seconds: 2),
          () => Routers.goRoute(context, Routers.toMenu));
    } else if (authState == AuthEnum.FAILED) {
      showSnackB(context, model);
    } else {
      throw Exception(StringConstants.authEnumExcept);
    }
  }
}
