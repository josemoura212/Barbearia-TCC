import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();


//verificar dps o pq não funciona
extension UnFocusExtension on BuildContext {
  void unfocus() => Focus.of(this).unfocus();
}
