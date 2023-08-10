import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants/color_constants.dart';
import '../constants/constants/string_constants.dart';
import '../product/vm/login/login_view_model.dart';

class CustomLoginButton extends ConsumerWidget {
  CustomLoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final loginViewModel = LoginViewModel();

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: InkWell(
        onTap: () async {
          return await loginViewModel
              .loginUser(ref, emailController, passwordController)
              .then((model) {
            loginViewModel.interactByAuthState(model, context);
          });
        },
        child: Container(
          width: 350,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.colorPurple,
          ),
          child: const Center(
            child: Text(
              StringConstants.loginText,
              style: TextStyle(
                color: ColorConstants.colorWhite,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
