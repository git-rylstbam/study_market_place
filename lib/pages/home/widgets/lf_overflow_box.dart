import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// CreateDate: 2025/7/10 9:54
/// Author: Lee
/// Description:

class LFOverflowBox extends SingleChildRenderObjectWidget {
  const LFOverflowBox({
    super.key,
    this.alignment = Alignment.center,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    super.child,
  });

  final AlignmentGeometry alignment;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderLFConstrainedOverflowBox(
        alignment: alignment,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        textDirection: Directionality.maybeOf(context),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderLFConstrainedOverflowBox renderObject,
  ) => renderObject
    ..alignment = alignment
    ..minWidth = minWidth
    ..maxWidth = maxWidth
    ..minHeight = minHeight
    ..maxHeight = maxHeight
    ..textDirection = Directionality.maybeOf(context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<AlignmentGeometry>('aligment', alignment),
    );
    properties.add(DoubleProperty('minWidth', minWidth, defaultValue: null));
    properties.add(DoubleProperty('maxWidth', maxWidth, defaultValue: null));
    properties.add(DoubleProperty('minHeight', minHeight, defaultValue: null));
    properties.add(DoubleProperty('maxHeight', maxHeight, defaultValue: null));
  }
}

class RenderLFConstrainedOverflowBox extends RenderAligningShiftedBox {
  RenderLFConstrainedOverflowBox({
    super.child,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    super.alignment,
    super.textDirection,
  }) : _minWidth = minWidth,
       _maxWidth = maxWidth,
       _minHeight = minHeight,
       _maxHeight = maxHeight;

  double? get minWidth => _minWidth;
  double? _minWidth;

  set minWidth(double? value) {
    if (_minWidth == value) return;
    _minWidth = value;
    markNeedsLayout();
  }

  double? get maxWidth => _maxWidth;
  double? _maxWidth;

  set maxWidth(double? value) {
    if (_maxWidth == value) return;
    _maxWidth = value;
    markNeedsLayout();
  }

  double? get minHeight => _minHeight;
  double? _minHeight;

  set minHeight(double? value) {
    if (_minHeight == value) return;
    _minHeight = value;
    markNeedsLayout();
  }

  double? get maxHeight => _maxHeight;
  double? _maxHeight;

  set maxHeight(double? value) {
    if (_maxHeight == value) return;
    _maxHeight = value;
    markNeedsLayout();
  }

  BoxConstraints _getInnerConstraints(BoxConstraints constraints) {
    final maxWidthTemp = _maxWidth ?? constraints.maxWidth;
    final maxHeightTemp = _maxHeight ?? constraints.maxHeight;
    return BoxConstraints(
      minWidth: _minWidth ?? constraints.minWidth,
      maxWidth: _minWidth == null || _maxWidth != null
          ? maxWidthTemp
          : max(maxWidthTemp, _minWidth!),
      minHeight: _minHeight ?? constraints.minHeight,
      maxHeight: _minHeight == null || _maxHeight != null
          ? maxHeightTemp
          : max(maxHeightTemp, _minHeight!),
    );
  }

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  @override
  void performLayout() {
    if (child == null) return;
    child!.layout(_getInnerConstraints(constraints), parentUsesSize: true);
    alignChild();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DoubleProperty(
        'minWidth',
        minWidth,
        ifNull: 'use parent minWidth constraint',
      ),
    );
    properties.add(
      DoubleProperty(
        'maxWidth',
        maxWidth,
        ifNull: 'use parent maxWidth constraint',
      ),
    );
    properties.add(
      DoubleProperty(
        'minHeight',
        minHeight,
        ifNull: 'use parent minHeight constraint',
      ),
    );
    properties.add(
      DoubleProperty(
        'maxHeight',
        maxHeight,
        ifNull: 'use parent maxHeight constraint',
      ),
    );
  }
}
