import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routers {
  static get toSplash => '/';
  static get toLogin => '/login';
  static get toMenu => '/menu';
  static get toOwnStore => 'own_store';
  static get ownStoreParameterName => 'storeName';
  static get toManageStore => '/manage_store';

  static goRoute(BuildContext context, String path) {
    context.go(path);
  }

  static goRouterSingleParameters(
      BuildContext context, String path, paramaterName, parameter) {
    return context.goNamed(path, pathParameters: {paramaterName: parameter});
  }
}
