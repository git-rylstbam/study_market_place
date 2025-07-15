import 'package:flutter/material.dart';

import '../extensions/list_extension.dart';
import '../resources/colors.dart';

/// CreateDate: 2025/7/14 17:59
/// Author: Lee
/// Description:

class LFOutermostShell extends StatelessWidget {
  const LFOutermostShell({
    super.key,
    this.title,
    this.subs,
    this.trailings,
    this.bottom,
    this.child,
    this.footer,
  });

  final String? title;
  final List<Widget>? subs;
  final List<Widget>? trailings;
  final Widget? bottom;
  final Widget? child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _header,
      if (bottom != null) bottom!,
      if (child != null) child!,
      if (footer != null) ...[
        const SizedBox(height: 22.0),
        footer!,
        const SizedBox(height: 15.0),
      ],
    ],
  );

  Widget get _header => Container(
    padding: const EdgeInsets.symmetric(horizontal: 60.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: MyColors.dividerColor)),
    ),
    height: 60.0,
    child: Row(
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        if (subs != null) ...subs!,
        const Spacer(),
        if (trailings != null)
          SizedBox(
            height: 32.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: trailings!.mapWithSeparator(
                (e) => const SizedBox(width: 20.0),
              ),
            ),
          ),
      ],
    ),
  );
}
