import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/colors.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static LoginPageState of(BuildContext context) =>
      context.findAncestorStateOfType<LoginPageState>()!;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Stack(children: [_background, _icon, _block]));

  Widget get _background => Align(
    alignment: Alignment.bottomLeft,
    child: Stack(
      alignment: const Alignment(-.65, .2),
      children: [
        Lottie.asset(
          'assets/lottie/background.json',
          addRepaintBoundary: true,
          fit: BoxFit.cover,
        ),
        Text(
          _kWelcomeText,
          style: const TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  Widget get _icon => Positioned(
    left: 32.0,
    top: 22.0,
    child: Image.asset('assets/png/logo.png', width: 220.0, fit: BoxFit.fill),
  );

  Widget get _block => Align(
    alignment: const Alignment(.8, .0),
    child: Stack(children: [_input]),
  );

  Widget get _input => AnimatedContainer(
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
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 66.0),
      child: LoginBlock(),
    ),
  );
}
