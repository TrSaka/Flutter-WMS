import 'package:stock_app/core/constants/constants/string_constants.dart';

import '../constants/constants/color_constants.dart';
import '../constants/enum/auth_enum.dart';
import '../mixins/validate_mixin.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget with ValidationMixin {
  AuthTextFormField(
      {super.key, required this.formType, required this.controller});

  final AuthEnum formType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool isEmailForm = (formType == AuthEnum.EMAIL ? true : false);
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 20,
          right: MediaQuery.of(context).size.width / 20,
          top: 12.5),
      child: TextFormField(
        controller: controller,
        validator: (input) => isEmailForm
            ? emailValidationBySentence(input ?? '')
            : passwordValidationMixin(input ?? ''),
        obscureText: !isEmailForm,
        decoration: InputDecoration(
          prefixIcon: Icon(isEmailForm == true ? Icons.email : Icons.key),
          prefixIconColor: ColorConstants.colorPurple,
          border: OutlineInputBorder(
            borderSide: const BorderSide(), // İstediğiniz renk
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: isEmailForm
              ? StringConstants.emailText
              : StringConstants.passwordText,
        ),
      ),
    );
  }
}
