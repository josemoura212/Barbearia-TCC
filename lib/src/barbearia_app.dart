import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/ui/barberaria_theme.dart';
import 'package:barbearia_tcc/src/core/ui/widget/loader.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_page.dart';
import 'package:barbearia_tcc/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbeariaApp extends StatelessWidget {
  const BarbeariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const Loader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: BarberariaTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (context) => const LoginPage(),
          },
        );
      },
    );
  }
}
