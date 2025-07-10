import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import 'lf_layout_theme.dart';

/// CreateDate: 2025/7/9 17:41
/// Author: Lee
/// Description:

class MyAppHeader extends StatelessWidget {
  const MyAppHeader({
    super.key,
    this.leading,
    this.middle,
    this.trailing,
    this.height = 50.0,
  });

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    final padding = LFLayoutTheme.of(context).mainViewPaddingWith(-20.0);
    return SizedBox(
      height: height,
      child: Material(
        color: MyColors.headerColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: NavigationToolbar(
            leading: leading,
            middle: middle,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
