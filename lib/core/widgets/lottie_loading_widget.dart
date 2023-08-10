
import 'package:flutter/material.dart';
import '../constants/constants/asset_constants.dart';
import '../extensions/image_extensions.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child : ImageExt(AssetConstants.splashAnimation).toLottie(75, 75),
    );
  }
}