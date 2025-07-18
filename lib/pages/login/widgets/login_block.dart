import 'package:flutter/material.dart';

import '../../../core/app_service.dart';
import '../../../core/configs.dart';
import '../../../http/http.dart';
import '../../../main.dart';
import '../../../routes.dart';
import '../../../widgets/lf_elevated_button.dart';
import '../../../widgets/lf_label_textfield.dart';
import '../model/login_model.dart';

/// CreateDate: 2025/7/4 17:23
/// Author: Lee
/// Description:

class LoginBlock extends StatefulWidget {
  const LoginBlock({super.key});

  @override
  State<LoginBlock> createState() => _LoginBlockState();
}

class _LoginBlockState extends State<LoginBlock> {
  final _emailController = TextEditingController(
    text: EnvConfig.isProd ? null : 'mp@lf.net', // 1147468701@qq.com
  );

  final _secretController = TextEditingController(
    text: EnvConfig.isProd ? null : 'Links@2024', // Links@2025
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
        const Text(
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
        const SizedBox(height: 18.0),
        LFElevatedButton(
          label: 'Login',
          height: 44.0,
          textStyle: const TextStyle(fontSize: 17.0),
          isExpanded: true,
          onPressed: _login,
        ),
      ],
    ),
  );

  Future<void> _login() async {
    final body = LoginRequestEntity(
      username: _emailController.text,
      password: _secretController.text,
    );
    final value = await Http.getLoginApi().login(body);
    if (value.isFaield) return;
    if (value.data == null) return;
    if (value.data!.access_token == null) return;
    _queryUserInfo(value.data!.access_token!);
  }

  Future<void> _queryUserInfo(String token) async {
    final value = await Http.getLoginApi().queryUserInfo(token: token);
    if (value.isFaield) return;
    await AppService.to.saveUserInfo(token, value);
    Globals.outNavigatorState.pushReplacementNamed(Routes.home);
  }
}
