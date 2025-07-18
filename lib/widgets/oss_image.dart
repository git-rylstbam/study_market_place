// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/target_config/target.dart';
import '../http/http.dart';

/// CreateDate: 2025/7/16 14:50
/// Author: Lee
/// Description:

/// 通过OSS获取图片
///
/// 如果[height]或[width]不为空，则会请求缩略图，否则请求原图
class LFImage extends StatelessWidget {
  LFImage.oss(
    String path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.loadingBuilder,
    this.errorBuilder,
  }) : url = buildOssUrl(path, width: width, height: height, fit: fit);

  LFImage.fullPathOss(
    String path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.loadingBuilder,
    this.errorBuilder,
  }) : url = buildOssUrl(
         path,
         width: width,
         height: height,
         fit: fit,
         isFullPath: true,
       );

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final ImageLoadingBuilder? loadingBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;

  static String buildOssUrl(
    String path, {
    double? width,
    double? height,
    required BoxFit fit,
    bool isFullPath = false,
  }) {
    String baseUrl = isFullPath ? path : '${LFConfigs().ossBaseUrl}$path';
    if (width != null || height != null) {
      String params = 'image/resize';
      params +=
          ',m_${switch (fit) {
            BoxFit.contain => 'lfit',
            _ => 'fill',
          }}';
      if (width != null) {
        params += ',w_${width.toInt()}';
      }
      if (height != null) {
        params += ',h_${height.toInt()}';
      }
      baseUrl = '$baseUrl?x-oss-process=$params';
    }
    return baseUrl;
  }

  @override
  Widget build(BuildContext context) => Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    loadingBuilder: loadingBuilder,
    errorBuilder: errorBuilder,
    frameBuilder: (_, child, frame, __) => AnimatedSwitcher(
      duration: const Duration(milliseconds: 266),
      child: frame != null ? child : null,
    ),
  );
}

@Deprecated('Use LFImage.oss instead')
class OSSImage extends ImageProvider<OSSImage> {
  @Deprecated('Use LFImage.oss instead')
  const OSSImage(this.path, {this.scale = 1.0, this.headers});

  final String path;
  final double scale;
  final Map<String, String>? headers;

  @override
  Future<OSSImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<OSSImage>(this);

  @override
  ImageStreamCompleter loadImage(OSSImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(
        codec: _loadAsync(key, decode),
        scale: key.scale,
        debugLabel: key.path,
        informationCollector: () => <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<OSSImage>('Image key', key),
        ],
      );

  Future<Codec> _loadAsync(OSSImage key, ImageDecoderCallback decode) async {
    assert(key == this);
    final data = await Http.getFileApi().queryFileByUrl(path);
    final buffer = await ImmutableBuffer.fromUint8List(data);
    return decode(buffer);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is OSSImage && other.path == path && other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(path, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'OSSImage')}("$path", scale: $scale)';
}
