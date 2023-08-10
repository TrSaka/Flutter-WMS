import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/core/constants/enum/cache_enum.dart';
import 'package:stock_app/core/product/routes/router.dart';
import 'package:stock_app/core/riverpod/cache_riverpod.dart';

class SplashViewModel {
  Future<bool> checkRememberMe(WidgetRef ref) async {
    return await ref
                .read(cacheProvider.notifier)
                .fetchRememberMe(SharedPreferencesKeys.REMEMBER_ME) !=
            null
        ? true
        : false;

    //if remember me is null, user not remember equals false
  }

  navigatePageByState(BuildContext context, state) {
    Future.delayed(
      const Duration(seconds: 3),
      () => Routers.goRoute(context, (state == true ? Routers.toSplash : Routers.toLogin)),
    );
  }
}
