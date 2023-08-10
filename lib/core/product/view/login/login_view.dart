import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/app/global/app_global.dart';
import 'package:stock_app/core/constants/constants/asset_constants.dart';
import 'package:stock_app/core/constants/constants/color_constants.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';
import 'package:stock_app/core/constants/enum/auth_enum.dart';
import 'package:stock_app/core/extensions/image_extensions.dart';
import 'package:stock_app/core/mixins/validate_mixin.dart';
import '../../../widgets/auth_form_field.dart';
import '../../../widgets/login_button_widget.dart';
import '../../../widgets/login_contact_text_widget.dart';
import '../../vm/login/login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with ValidationMixin {
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    _loginViewModel.initalizeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: _loginViewModel,
      onModelReady: (model) {
        model = _loginViewModel;
      },
      onDispose: () => _loginViewModel.disposeController(),
      onPageBuilder: (context, value) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: appBarText(),
          ),
          backgroundColor: ColorConstants.colorWhite,
          body: Row(
            children: [
              Expanded(
                child: image(),
              ),
              Expanded(
                child: Form(
                  key: GlobalConstants.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextFormField(
                          formType: AuthEnum.EMAIL,
                          controller: _loginViewModel.emailController),
                      AuthTextFormField(
                          formType: AuthEnum.PASSWORD,
                          controller: _loginViewModel.passwordController),
                      CustomLoginButton(
                        emailController: _loginViewModel.emailController,
                        passwordController: _loginViewModel.passwordController,
                      ),
                      //we give each controller manuel because when we interact it or dispose it
                      //We want they must use the same controller without state management.
                      const SizedBox(height: 10),
                      const LoginContactTextWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Text appBarText() {
    return Text(
      StringConstants.loginAppBarText,
      style: TextStyle(
          color: ColorConstants.colorPurple, fontWeight: FontWeight.w300),
    );
  }

  Center image() {
    return Center(
      child: ImageExt(AssetConstants.loginLogo).toSvg(300, 400),
    );
  }
}
