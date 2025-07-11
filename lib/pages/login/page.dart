import 'package:flutter/material.dart';

import '../../core/configs.dart';
import '../../resources/colors.dart';
import '../../theme.dart';
import 'widgets/login_block.dart';

/// CreateDate: 2025/7/4 16:24
/// Author: Lee
/// Description:

const _kWelcomeText = '''
Hello!
Welcome to
Links Field
marketplace
''';

const _kBlockSwitchingDuration = Duration(milliseconds: 266);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Stack(
            alignment: const Alignment(-.75, .55),
            children: [
              _background,
              const Text(
                _kWelcomeText,
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 32.0,
          top: 22.0,
          child: Text(EnvConfig.logoName, style: TextStyle(fontSize: 60.0)),
        ),
        Align(
          alignment: const Alignment(.8, .0),
          child: Stack(children: [_block, _fontSwitcher]),
        ),
      ],
    ),
  );

  Widget get _background => Stack(
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

  Widget get _block => AnimatedContainer(
    duration: _kBlockSwitchingDuration,
    curve: Curves.easeInOut,
    width: 540.0,
    height: 460.0,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      boxShadow: [
        BoxShadow(
          color: MyColors.defaultColor,
          blurRadius: 12.0,
          offset: Offset(.0, 6.0),
        ),
      ],
    ),
    child: const SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 66.0),
      child: LoginBlock(),
    ),
  );

  Widget get _fontSwitcher => Positioned(
    top: 24.0,
    right: 24.0,
    child: Material(
      type: MaterialType.transparency,
      child: TooltipVisibility(
        visible: false,
        child: PopupMenuButton(
          itemBuilder: (_) =>
              fonts.map((e) => PopupMenuItem(child: Text(e))).toList(),
          onSelected: (e) {},
          icon: const Icon(Icons.translate, size: 24.0),
        ),
      ),
    ),
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
