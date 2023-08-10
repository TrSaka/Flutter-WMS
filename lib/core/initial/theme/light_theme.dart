import 'package:flutter/material.dart';
import 'package:stock_app/core/initial/theme/app_theme.dart';

import '../../constants/constants/color_constants.dart';

class ThemeLight extends AppTheme {
  static ThemeData get lightTheme => ThemeData(
        backgroundColor: ColorConstants.colorWhite,
        primaryColor: ColorConstants.colorPurple,
      );
}
