import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../extensions/list_extension.dart';
import 'lf_pagination_button.dart';

/// CreateDate: 2025/7/17 16:20
/// Author: Lee
/// Description:

const _kDefaultSupportedPageSize = [if (kDebugMode) 1, 10, 50, 100];

class LFPagination extends StatefulWidget {
  const LFPagination({
    super.key,
    required this.total,
    this.pageSize = 10,
    required this.pageNum,
    required this.onSelected,
    this.controller,
    this.alignment = MainAxisAlignment.center,
  });

  final int total;
  final int pageSize;
  final int pageNum;
  final FutureOr<void> Function(int) onSelected;
  final ScrollController? controller;
  final MainAxisAlignment alignment;

  @override
  State<LFPagination> createState() => _LFPaginationState();
}

class _LFPaginationState extends State<LFPagination> {
  late List<int> _options = List.generate(
    max((widget.total / widget.pageSize).ceil(), 1),
    (index) => index + 1,
  );

  late ScrollController? _effectiveController = widget.controller;

  @override
  void didUpdateWidget(LFPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget == oldWidget) return;
    if (widget.total != oldWidget.total ||
        widget.pageSize != oldWidget.pageSize) {
      _options = List.generate(
        max((widget.total / widget.pageSize).ceil(), 1),
        (index) => index + 1,
      );
    }
    if (widget.controller != oldWidget.controller) {
      _effectiveController = widget.controller;
    }
  }

  List<int> get _displays {
    assert(_options.contains(widget.pageNum), '$_options,${widget.pageNum}');
    if (_options.length <= 7) return _options;
    final index = _options.indexOf(widget.pageNum);
    final int left;
    final int? right;
    if (index < 3) {
      left = 0;
      right = 7;
    } else if (index >= _options.length - 3) {
      left = _options.length - 7;
      right = null;
    } else {
      left = index - 3;
      right = index + 4;
    }
    return _options.sublist(left, right);
  }

  Future<void> _handle(int pageNum) async {
    if (pageNum == widget.pageNum) return;
    await widget.onSelected(pageNum);
    _effectiveController?.animateTo(
      .0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCirc,
    );
  }

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: widget.alignment,
    mainAxisSize: MainAxisSize.min,
    children: [
      _buildPaginationChild(
        isControlButton: true,
        onPressed: widget.pageNum > 1 ? () => _handle(1) : null,
        child: const Icon(Icons.first_page, size: 20.0),
      ),
      _buildPaginationChild(
        isControlButton: true,
        onPressed: widget.pageNum > 1
            ? () => _handle(widget.pageNum - 1)
            : null,
        child: const Icon(Icons.chevron_left, size: 20.0),
      ),
      ..._displays.map(
        (e) => _buildPaginationChild(
          index: e,
          onPressed: e == widget.pageNum ? null : () => _handle(e),
          child: Text(e.toString(), style: const TextStyle(fontSize: 14.0)),
        ),
      ),
      _buildPaginationChild(
        isControlButton: true,
        onPressed: widget.pageNum < _options.length
            ? () => _handle(widget.pageNum + 1)
            : null,
        child: const Icon(Icons.chevron_right, size: 20.0),
      ),
      _buildPaginationChild(
        isControlButton: true,
        onPressed: widget.pageNum < _options.length
            ? () => _handle(_options.length)
            : null,
        child: const Icon(Icons.last_page, size: 20.0),
      ),
    ].mapWithSeparator((e) => const SizedBox(width: 10.0)),
  );

  Widget _buildPaginationChild({
    void Function()? onPressed,
    Widget? child,
    int? index,
    bool isControlButton = false,
  }) => LFPaginationButton(
    isSelected: index == widget.pageNum,
    onPressed: onPressed,
    style: TextStyle(
      fontSize: 18.0,
      color: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else if (states.contains(WidgetState.disabled)) {
          return const Color(0xFFC6C7C8);
        }
        return const Color(0xFF979797);
      }),
    ),
    child: child,
  );
}
