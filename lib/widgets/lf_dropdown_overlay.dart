import 'package:flutter/material.dart';

import '../resources/colors.dart';
import 'lf_textfield.dart';

/// CreateDate: 2025/7/15 14:52
/// Author: Lee
/// Description:

const kDropdownOverlayMaxHeight = 280.0;

class LFDropdownOverlay<T> extends StatefulWidget {
  const LFDropdownOverlay({
    super.key,
    this.hint,
    required this.data,
    this.initialValue,
    required this.display,
    this.onSelected,
    this.enabled = true,
    this.height = kDropdownOverlayMaxHeight,
  });

  final String? hint;
  final List<T> data;
  final T? initialValue;
  final String Function(T value) display;
  final void Function(T? value)? onSelected;
  final bool enabled;
  final double height;

  @override
  State<LFDropdownOverlay<T>> createState() => _LFDropdownOverlayState<T>();
}

class _LFDropdownOverlayState<T> extends State<LFDropdownOverlay<T>> {
  final _key = GlobalKey();
  final _layerLink = LayerLink();
  late final TextEditingController _controller;
  final _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(
      widget.initialValue == null
          ? null
          : TextEditingValue(text: widget.display(widget.initialValue as T)),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlayEntry();
      } else {
        _overlayEntry?.remove();
        _overlayEntry?.dispose();
        _overlayEntry = null;
      }
    });
  }

  @override
  void didUpdateWidget(LFDropdownOverlay<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue == oldWidget.initialValue) return;
    _controller.text = widget.initialValue == null
        ? ''
        : widget.display(widget.initialValue as T);
    if (widget.data.isEmpty) _controller.text = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _layerLink,
    child: LFTextField(
      key: _key,
      hintText: widget.hint,
      controller: _controller,
      enabled: widget.enabled,
      focusNode: _focusNode,
      suffix: widget.enabled
          ? ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, value, __) =>
                  value.text.isEmpty || !_focusNode.hasFocus
                  ? const Icon(Icons.expand_more)
                  : _buildClearButton(),
            )
          : null,
    ),
  );

  Widget _buildClearButton() => OverflowBox(
    minWidth: 28.0,
    maxWidth: 28.0,
    minHeight: 28.0,
    maxHeight: 28.0,
    child: IconButton(
      onPressed: () {
        _controller.clear();
        _focusNode.unfocus();
        if (widget.onSelected == null) return;
        widget.onSelected!(null);
      },
      padding: EdgeInsets.zero,
      splashRadius: 24.0,
      iconSize: 14.0,
      icon: const Icon(Icons.close),
    ),
  );

  void _showOverlayEntry() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    final render = (_key.currentContext?.findRenderObject())! as RenderBox;
    final size = render.size;
    return OverlayEntry(
      builder: (_) => CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(.0, size.height + 1.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: TextFieldTapRegion(
            child: DropdownOverlay(
              controller: _controller,
              width: size.width,
              data: widget.data,
              display: widget.display,
              onItemSelected: (value) {
                if (widget.onSelected == null) return;
                widget.onSelected!(value);
                _focusNode.unfocus();
              },
              height: widget.height,
            ),
            onTapOutside: (_) => _focusNode.unfocus(),
          ),
        ),
      ),
    );
  }
}

class DropdownOverlay<T> extends StatefulWidget {
  const DropdownOverlay({
    super.key,
    required this.controller,
    required this.width,
    required this.data,
    required this.display,
    required this.onItemSelected,
    this.height = kDropdownOverlayMaxHeight,
  });

  final TextEditingController controller;
  final double width;
  final List<T> data;
  final String Function(T value) display;
  final void Function(T value) onItemSelected;
  final double height;

  @override
  State<DropdownOverlay<T>> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T> extends State<DropdownOverlay<T>> {
  late List<T> _displayList;
  bool _isClickEvent = false;

  @override
  void initState() {
    super.initState();
    _displayList = widget.data;
    widget.controller.addListener(() {
      if (_isClickEvent) return;
      setState(() {
        _displayList = widget.data
            .where(
              (e) => widget
                  .display(e)
                  .toLowerCase()
                  .contains(widget.controller.text.toLowerCase()),
            )
            .toList();
        _isClickEvent = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Material(
    shadowColor: MyColors.defaultColor,
    elevation: 6.0,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
        maxHeight: widget.height,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: MyColors.defaultColor),
          color: Colors.white,
        ),
        child: _buildDropdownChild(),
      ),
    ),
  );

  Widget _buildDropdownChild() => ListTileTheme(
    child: ListView.separated(
      itemBuilder: (_, index) => _buildSingleChild(index),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: .5,
        thickness: .5,
        color: MyColors.defaultColor.withAlpha(128),
      ),
      itemCount: _displayList.length,
    ),
  );

  Widget _buildSingleChild(int index) => ListTile(
    onTap: () {
      _isClickEvent = true;
      widget.controller.text = widget.display(_displayList[index]);
      widget.onItemSelected(_displayList[index]);
    },
    hoverColor: MyColors.defaultColor.withAlpha(128),
    title: _buildChildTitle(index),
  );

  Widget _buildChildTitle(int index) => Center(
    child: Text(
      widget.display(_displayList[index]),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 12.0,
        color: MyColors.defaultColor,
        fontWeight: FontWeight.w100,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
