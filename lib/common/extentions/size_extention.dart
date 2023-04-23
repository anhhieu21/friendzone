import 'package:flutter/material.dart';

extension SizeEx on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}
