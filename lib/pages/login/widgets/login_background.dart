import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

/// CreateDate: 2025/7/9 14:26
/// Author: Lee
/// Description:

class LoginBackground extends StatefulWidget {
  const LoginBackground({super.key});

  @override
  State<LoginBackground> createState() => _LoginBackgroundState();
}

class _LoginBackgroundState extends State<LoginBackground> {
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(
        left: 100.0,
        bottom: 100.0,
        child: CustomPaint(
          size: const Size.square(500.0),
          painter: _SolidCirclePainter(),
        ),
      ),
      Positioned(
        top: 100.0,
        right: 100.0,
        child: CustomPaint(
          size: const Size.square(500.0),
          painter: _SolidCirclePainter(),
        ),
      ),
    ],
  );
}

class _SolidCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyColors.defaultColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SolidCirclePainter oldDelegate) => false;
}
