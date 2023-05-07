import 'package:flutter/material.dart';
import 'package:friendzone/common/constants/constants.dart';

class CustomOverlayEntry {
  static final instance = CustomOverlayEntry._();
  CustomOverlayEntry._();
  OverlayEntry? _overlayEntry;
  final _overlay = Overlay.of(navigatorKey.currentContext!);
  void showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => const Positioned(
        top: 100.0,
        left: 100.0,
        child: Material(
          child: Text('Hello world!'),
        ),
      ),
    );
    _overlay.insert(_overlayEntry!);
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
