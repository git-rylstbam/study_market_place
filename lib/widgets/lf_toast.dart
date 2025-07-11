import 'package:flutter/material.dart';

import '../resources/colors.dart';

/// CreateDate: 2025/7/8 17:32
/// Author: Lee
/// Description:

class LFToast {
  static bool _visible = false;

  static void toast(BuildContext context, String? message) {
    if (_visible) return;
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          elevation: 10.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Text(
              message ?? '',
              style: const TextStyle(
                fontSize: 14.0,
                color: MyColors.defaultColor,
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    _visible = true;
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
      _visible = false;
    });
  }
}
