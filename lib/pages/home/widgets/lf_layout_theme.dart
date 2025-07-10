import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// CreateDate: 2025/7/9 17:15
/// Author: Lee
/// Description:

class LFLayoutTheme extends InheritedTheme {
  const LFLayoutTheme({super.key, required this.data, required super.child});

  static LFLayoutThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LFLayoutTheme>()?.data ??
      const LFLayoutThemeData();

  final LFLayoutThemeData data;

  @override
  bool updateShouldNotify(LFLayoutTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      LFLayoutTheme(data: data, child: child);
}

@immutable
class LFLayoutThemeData with Diagnosticable {
  const LFLayoutThemeData({this.mainViewHPadding = 60.0});

  final double mainViewHPadding;

  double mainViewPaddingWith(double padding) =>
      (mainViewHPadding + padding).clamp(.0, double.infinity);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is LFLayoutThemeData &&
        other.mainViewHPadding == mainViewHPadding;
  }

  @override
  int get hashCode => mainViewHPadding.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    const defaultTheme = LFLayoutThemeData();
    properties.add(
      DoubleProperty(
        'mainViewHPadding',
        mainViewHPadding,
        defaultValue: defaultTheme.mainViewHPadding,
      ),
    );
  }
}
