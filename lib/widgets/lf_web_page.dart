// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

/// CreateDate: 2025/7/14 16:14
/// Author: Lee
/// Description:

@JS()
external set loadComplete(JSFunction? value);

class LFWebPage extends StatefulWidget {
  const LFWebPage({super.key, required this.uri, this.onLoadComplete});

  final Uri uri;

  static final controllers = <Uri, WebWebViewController>{};

  final JSFunction? onLoadComplete;

  @override
  State<LFWebPage> createState() => _LFWebPageState();
}

class _LFWebPageState extends State<LFWebPage> {
  final _params = WebWebViewControllerCreationParams();

  web.Window? get window => _params.iFrame.contentWindow;

  late final _controller = WebWebViewController(_params)
    ..loadRequest(LoadRequestParams(uri: widget.uri));

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance ??= WebWebViewPlatform();
    LFWebPage.controllers[widget.uri] = _controller;
    loadComplete = widget.onLoadComplete;
  }

  @override
  void dispose() {
    LFWebPage.controllers.remove(widget.uri);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.uri.toString(), style: const TextStyle(fontSize: 60.0)),
            const SizedBox(height: 4.0),
            const Text(
              '只在debug模式下显示，正式环境将会正常显示网页',
              style: TextStyle(fontSize: 60.0),
            ),
          ],
        ),
      );
    }
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context);
  }
}
