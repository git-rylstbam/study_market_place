import 'package:flutter/material.dart';

import '../resources/colors.dart';

/// CreateDate: 2025/7/14 18:24
/// Author: Lee
/// Description:

Path dashPath(
  Path source, {
  required CircularIntervalList<double> dashArray,
  DashOffset? dashOffset,
}) {
  dashOffset = dashOffset ?? const DashOffset.absolute(.0);
  final dest = Path();
  for (final metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    bool draw = true;
    while (distance < metric.length) {
      final len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }
  return dest;
}

class LFDottedBorder extends Border {
  const LFDottedBorder({
    this.width = 1.5,
    this.color = MyColors.defaultColor,
    this.values = const [5.0, 3.0],
  }) : assert(width > .0);

  final double width;
  final Color color;
  final List<double> values;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (!isUniform || width <= .0) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Path path = Path();
    if (shape == BoxShape.circle) {
      assert(
        borderRadius == null,
        'A borderRadius can only be given for rectangular boxes.',
      );
      path.addOval(rect);
    }
    if (shape == BoxShape.rectangle) {
      if (borderRadius == null) {
        path.addRect(rect);
        return;
      }
      path.addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
          bottomLeft: borderRadius.bottomLeft,
          bottomRight: borderRadius.bottomRight,
        ),
      );
    }
    path = dashPath(path, dashArray: CircularIntervalList(values));
    canvas.drawPath(path, paint);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is LFDottedBorder &&
        other.color == color &&
        other.width == width &&
        other.values == values;
  }

  @override
  int get hashCode => Object.hash(color, width, values);
}

enum _DashOffsetType { Absolute, Percentage }

class DashOffset {
  DashOffset.percentage(double percentage)
    : _rawVal = percentage.clamp(.0, 1.0),
      _dashOffsetType = _DashOffsetType.Percentage;

  const DashOffset.absolute(double start)
    : _rawVal = start,
      _dashOffsetType = _DashOffsetType.Absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) =>
      _dashOffsetType == _DashOffsetType.Absolute ? _rawVal : length * _rawVal;
}

class CircularIntervalList<T> {
  CircularIntervalList(this._vals);

  final List<T> _vals;
  int _idx = 0;

  T get next {
    if (_idx >= _vals.length) _idx = 0;
    return _vals[_idx++];
  }
}
