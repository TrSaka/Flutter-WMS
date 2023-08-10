import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

extension ImageExt on dynamic {
  toImage(double height, double width) {
    return Image(
      image: AssetImage(this),
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }

  toSvg(double height, double width) {
    return SvgPicture.asset(
      this,
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }

  toLottie(double height, double width) {
    return SizedBox(
        height: 200,
        width: 200,
        child: Lottie.asset(
          this,
          height: height,
          width: width,
          fit: BoxFit.cover,
          repeat: true,
        ));
  }
}
