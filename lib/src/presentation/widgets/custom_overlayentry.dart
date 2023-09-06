import 'package:flutter/material.dart';
import 'package:friendzone/src/config/themes/color.dart';

class CustomOverlayEntry {
  static final instance = CustomOverlayEntry._();
  CustomOverlayEntry._();

  OverlayEntry? _overlayEntry;

  /// Creates an overlay entry.
  ///
  /// [child] is children of stack
  /// Call [hideOverlay] to close
  void showOverlay(BuildContext context, {required Widget child}) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
              onTap: hideOverlay,
              child: Material(color: colorBlack.withOpacity(0.3)),
            )),
            child
          ],
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
