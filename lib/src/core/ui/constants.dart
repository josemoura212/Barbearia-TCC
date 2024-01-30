import 'package:flutter/material.dart';

sealed class FontConstants {
  static const fontfamily = 'Poppins';
}

sealed class ColorsConstants {
  static const primary = Color.fromARGB(255, 199, 99, 62);
  static const grey = Color.fromARGB(255, 145, 143, 143);
  static const error = Color.fromARGB(255, 221, 32, 19);
  static const teste = Color(0xFFB07B01);
}

sealed class AssetsImage {
  static const background1 = 'assets/images/background_imgteste.png';
  static const background2 = 'assets/images/background_img.png';
  static const logoBarbearia = 'assets/images/logo258.png';
  static const perfil = 'assets/images/perfil_90x90.png';
  static const perfilTransparente = 'assets/images/perfil_90x90_sem_fundo.png';
}
