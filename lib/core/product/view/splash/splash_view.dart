// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/base/base_view.dart';
import 'package:stock_app/core/constants/constants/asset_constants.dart';
import 'package:stock_app/core/extensions/image_extensions.dart';
import '../../vm/splash/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  Widget build(BuildContext context) {
    SplashViewModel _splashViewModel = SplashViewModel();

    return BaseView(
      viewModel: _splashViewModel,
      onPageBuilder: (context, value) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageExt(AssetConstants.splashAnimation).toLottie(200, 200),
            ],
          )),
        );
      },
      onModelReady: (model) async {
        await _splashViewModel.checkRememberMe(ref).then(
            (state) => _splashViewModel.navigatePageByState(context, state));
      },
    );
  }
}
