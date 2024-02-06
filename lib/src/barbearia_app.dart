import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/ui/barberaria_theme.dart';
import 'package:barbearia_tcc/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barbearia_tcc/src/core/ui/widget/loader.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_page.dart';
import 'package:barbearia_tcc/src/features/auth/register/user_register_page.dart';
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
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (context) => const LoginPage(),
            '/auth/register/user': (context) => const UserRegisterPage(),
            '/home/adm': (context) => const Text('ADM'),
            '/home/employee': (context) => const Text('Employee'),
          },
        );
      },
    );
  }
}
