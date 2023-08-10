import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../constants/constants/color_constants.dart';
import '../constants/constants/string_constants.dart';

class AnimatedSplashText extends StatelessWidget {
  const AnimatedSplashText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText(
          StringConstants.splashText,
          textStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: ColorConstants.colorWhite,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      repeatForever: true,
      pause: const Duration(milliseconds: 200),
      displayFullTextOnTap: false,
      stopPauseOnTap: false,
    );
  }
}
