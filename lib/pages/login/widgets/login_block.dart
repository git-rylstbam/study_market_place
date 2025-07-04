import 'package:flutter/material.dart';
import 'package:study_market_place/core/configs.dart';
// import 'package:study_market_place/pages/login/page.dart';
import 'package:study_market_place/widgets/lf_label_textfield.dart';

/// CreateDate: 2025/7/4 17:23
/// Author: Lee
/// Description:

class LoginBlock extends StatefulWidget {
  const LoginBlock({super.key});

  @override
  State<LoginBlock> createState() => _LoginBlockState();
}

class _LoginBlockState extends State<LoginBlock> {
  // late final _state = LoginPage.of(context);

  final _emailController = TextEditingController(
    text: EnvConfig.isProd ? null : 'mp@lf.net',
  );

  final _secretController = TextEditingController(
    text: EnvConfig.isProd ? null : 'Links@2024',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AutofillGroup(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign In',
          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50.0),
        LFLabelTextField(
          autofillHints: const [AutofillHints.email],
          textInputAction: TextInputAction.next,
          autofocus: true,
          labelText: 'Username',
          controller: _emailController,
        ),
        const SizedBox(height: 32.0),
        LFObscureLabelTextField(
          autofillHints: const [AutofillHints.password],
          controller: _secretController,
          labelText: 'Password',
          onSubmitted: (_) => _login(),
        ),
      ],
    ),
  );

  Future<void> _login() async {}
}
