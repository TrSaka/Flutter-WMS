import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stock_app/core/product/view/menu/menu_view.dart';
import 'package:stock_app/core/product/view/store/manage/store_manage_view.dart';
import 'package:stock_app/core/product/view/store/own/store_view.dart';
import '../view/login/login_view.dart';
//import '../view/splash/splash_view.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MenuView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: 'menu',
          builder: (BuildContext context, GoRouterState state) {
            return const MenuView();
          },
        ),
        GoRoute(
          path:
              'own_store/:storeName', // 👈 Defination of params in the path is important
          name: 'own_store',
          builder: (context, state) => StoreView(
            storeName: state.pathParameters['storeName'],
           
          ),
        ),
        GoRoute(
          path: 'manage_store',
          builder: (BuildContext context, GoRouterState state) {
            return const StoreManageView();
          },
        ),
      ],
    ),
  ],
);
