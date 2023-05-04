import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(RenderBox renderBox);

class MeasureSizeRenderObject extends RenderProxyBox {
  RenderBox? oldRenderBox;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();
    RenderBox newSize = child!;
    if (oldRenderBox == newSize) return;
    oldRenderBox = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureRenderObject extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureRenderObject({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
