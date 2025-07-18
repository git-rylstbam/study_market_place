import 'package:flutter/material.dart';

import '../lf_dotted_border.dart';
import 'overlay_on_focused.dart';

/// CreateDate: 2025/7/16 16:33
/// Author: Lee
/// Description:

class DropdownOverlay extends StatelessWidget {
  const DropdownOverlay({
    super.key,
    required this.builder,
    required this.overlay,
    this.animationAlignment = Alignment.topLeft,
    this.offset = const Offset(.0, 6.0),
  });

  DropdownOverlay.text({
    super.key,
    required String text,
    required this.overlay,
    this.animationAlignment = Alignment.topLeft,
    this.offset = const Offset(.0, 6.0),
  }) : builder = _buildDefaultFocusableViewBuilder(text);

  final FocusableViewBuilder builder;
  final FocusableViewBuilder overlay;
  final Offset offset;
  final Alignment animationAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OverlayOnFocused(
      focusableViewBuilder: builder,
      offset: offset,
      followerAnchor: animationAlignment,
      targetAnchor: switch (animationAlignment) {
        Alignment.topLeft => Alignment.bottomLeft,
        Alignment.topRight => Alignment.bottomRight,
        Alignment.bottomLeft => Alignment.topLeft,
        Alignment.bottomRight => Alignment.topRight,
        Alignment.centerLeft => Alignment.centerRight,
        Alignment.centerRight => Alignment.centerLeft,
        Alignment.topCenter => Alignment.bottomCenter,
        Alignment.bottomCenter => Alignment.topCenter,
        _ => Alignment.bottomRight,
      },
      overlay: (context, focusNode) => Theme(
        data: theme,
        child: _AnimatedWhenShow(
          alignment: animationAlignment,
          child: Material(
            elevation: .6,
            color: theme.colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0)),
            ),
            shadowColor: theme.shadowColor,
            clipBehavior: Clip.hardEdge,
            child: overlay(context, focusNode),
          ),
        ),
      ),
    );
  }

  static FocusableViewBuilder _buildDefaultFocusableViewBuilder(String text) =>
      (context, focusNode) => Container(
        height: 40.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
          border: LFDottedBorder(),
        ),
        child: ElevatedButton(
          focusNode: focusNode,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23.0)),
            ),
            side: BorderSide.none,
            elevation: .0,
            padding: const EdgeInsets.only(left: 24.0, right: 16.0),
          ),
          onPressed: focusNode.requestFocus,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: const TextStyle(fontSize: 16.0, height: 1.3)),
              const SizedBox(width: 16.0),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
      );
}

class _AnimatedWhenShow extends StatefulWidget {
  const _AnimatedWhenShow({required this.child, required this.alignment});

  final Widget child;
  final Alignment alignment;

  @override
  State<_AnimatedWhenShow> createState() => _AnimatedWhenShowState();
}

class _AnimatedWhenShowState extends State<_AnimatedWhenShow> {
  int? _flag = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() => _flag = null),
    );
  }

  @override
  Widget build(BuildContext context) => _AnimatedOverlay(
    opacity: _flag == null ? 1.0 : .0,
    scale: _flag == null ? 1.0 : .8,
    alignment: widget.alignment,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 200),
    child: widget.child,
  );
}

class _AnimatedOverlay extends ImplicitlyAnimatedWidget {
  const _AnimatedOverlay({
    this.child,
    required this.alignment,
    required this.opacity,
    required this.scale,
    super.curve,
    required super.duration,
  }) : assert(opacity >= .0 && opacity <= 1.0);

  final Widget? child;
  final double opacity;
  final Alignment alignment;
  final double scale;

  @override
  ImplicitlyAnimatedWidgetState<_AnimatedOverlay> createState() =>
      _AnimatedOverlayState();
}

class _AnimatedOverlayState
    extends ImplicitlyAnimatedWidgetState<_AnimatedOverlay> {
  Tween<double>? _opacity;
  late Animation<double> _opacityAnimation;
  Tween<double>? _scale;
  late Animation<double> _scaleAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _opacity =
        visitor(
              _opacity,
              widget.opacity,
              (dynamic value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;
    _scale =
        visitor(
              _scale,
              widget.scale,
              (dynamic value) => Tween<double>(begin: value as double),
            )
            as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _opacityAnimation = animation.drive(_opacity!);
    _scaleAnimation = animation.drive(_scale!);
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _opacityAnimation,
    child: ScaleTransition(
      scale: _scaleAnimation,
      alignment: widget.alignment,
      child: widget.child,
    ),
  );
}
