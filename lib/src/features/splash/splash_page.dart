import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;
  double get _logoAnimation => 250 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_img.png'),
              fit: BoxFit.cover,
              opacity: 0.2),
        ),
        child: Center(
          child: AnimatedOpacity(
              duration: const Duration(seconds: 3),
              curve: Curves.easeIn,
              opacity: _animationOpacityLogo,
              onEnd: () {},
              child: AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  width: _logoAnimation,
                  height: _logoAnimation,
                  curve: Curves.linearToEaseOut,
                  child: Image.asset(
                    'assets/images/logo258x258.png',
                    fit: BoxFit.cover,
                  ))),
        ),
      ),
    );
  }
}
