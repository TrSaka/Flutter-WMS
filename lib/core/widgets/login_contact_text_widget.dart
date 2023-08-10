import 'package:flutter/material.dart';
import 'package:stock_app/core/constants/constants/string_constants.dart';

import '../constants/constants/color_constants.dart';

class LoginContactTextWidget extends StatelessWidget {
  const LoginContactTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConstants.problemOccouredText,
          style: TextStyle(color: ColorConstants.colorPurple),
        ),
        TextButton(
            onPressed: () {},
            child: Text(StringConstants.contactUsText,
                style: TextStyle(
                  color: ColorConstants.colorPurple,
                  fontWeight: FontWeight.bold,
                ))),
      ],
    );
  }
}
