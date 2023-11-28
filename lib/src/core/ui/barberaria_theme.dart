import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class BarberariaTheme {
  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: Colors.grey),
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      hintStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorBorder: _defaultInputBorder.copyWith(
          borderSide: const BorderSide(color: ColorsConstants.error)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    fontFamily: FontConstants.fontfamily,
  );
}
