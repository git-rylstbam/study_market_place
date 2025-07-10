import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// CreateDate: 2025/7/9 16:18
/// Author: Lee
/// Description:

extension GetExtension on GetInterface {
  /// 关闭某路由上的所有页面，如果没有该页面，则关闭所有页面后push该页面
  Future<T?>? lfOffNamedUntil<T>(
    String page, {
    RoutePredicate predicate = _offAll,
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (page == currentRoute) return null;
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return global(id).currentState?.pushNamedAndRemoveUntil<T>(
      page,
      predicate,
      arguments: arguments,
    );
  }

  T? argument<T>({required String key}) {
    final args = Get.arguments;
    if (args is! Map<String, dynamic>) return null;
    final temp = args[key];
    if (temp is! T) return null;
    return temp;
  }
}

bool _offAll(Route<dynamic> _) => false;
