import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/ui/widget/loader.dart';
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
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            navigatorObservers: [asyncNavigatorObserver],
            routes: {
              '/': (_) => const SplashPage(),
            },
          );
        });
  }
}
