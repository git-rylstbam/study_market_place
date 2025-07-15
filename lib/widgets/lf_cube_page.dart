import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import 'lf_web_page.dart';

/// CreateDate: 2025/7/14 16:28
/// Author: Lee
/// Description:

abstract class LFCubePage extends StatefulWidget {
  const LFCubePage({super.key});
}

mixin LFCubePageState<T extends LFCubePage> on State<T> {
  bool _isLoaded = false;

  String get title;

  String get path;

  Map<String, String?>? params;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      LFWebPage(
        uri: Uri.parse(
          '${web.window.location.origin}/SIM/$path',
        ).replace(queryParameters: {'source': 'mp', ...?params}),
        onLoadComplete: loaded.toJS,
      ),
      if (!_isLoaded) const Center(child: CircularProgressIndicator()),
    ],
  );

  void loaded(JSString? value) => setState(() => _isLoaded = true);
}
