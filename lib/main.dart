import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/firebase_options.dart';
import 'core/initial/theme/light_theme.dart';
import 'core/product/routes/go_router.dart';
import 'core/service/cache/shared_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalManagement.prefrencesInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Stock Application',
        theme: ThemeLight.lightTheme,
      ),
    );
  }
}
