import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_market_place/resources/colors.dart';

/// CreateDate: 2025/7/7 10:03
/// Author: Lee
/// Description:

typedef FutureVoidCallback = Future<void> Function();

class LFElevatedButton extends StatelessWidget {
  const LFElevatedButton({
    super.key,
    this.height,
    this.tooltip,
    required this.label,
    this.icon,
    this.borderRadius,
    this.style,
    this.onPressed,
    this.textStyle,
    this.isExpanded = false,
    this.autofocus = false,
  });

  final double? height;
  final String? tooltip;
  final String label;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;
  final ButtonStyle? style;

  /// 如果是异步操作，则会展示loading
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final bool isExpanded;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: .0,
      side: BorderSide.none,
      foregroundColor: Colors.white,
      disabledBackgroundColor: Colors.transparent,
      disabledForegroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: borderRadius == null
          ? null
          : RoundedRectangleBorder(borderRadius: borderRadius!),
    ).merge(style);
    final labelWidget = Text(label, style: textStyle);
    final content = onPressed is FutureVoidCallback
        ? _FutureElevatedButton(
            onPressed: onPressed! as FutureVoidCallback,
            label: labelWidget,
            autofocus: autofocus,
            style: buttonStyle,
            tooltip: tooltip,
            icon: icon,
          )
        : _Child(
            onPressed: onPressed,
            label: labelWidget,
            autofocus: autofocus,
            style: buttonStyle,
            tooltip: tooltip,
            icon: icon,
          );
    return Material(
      elevation: theme.brightness == Brightness.light ? 6.0 : .0,
      shadowColor: theme.shadowColor,
      borderRadius:
          borderRadius ?? const BorderRadius.all(Radius.circular(6.0)),
      child: Container(
        height: height,
        width: isExpanded ? double.infinity : null,
        decoration: BoxDecoration(
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(6.0)),
          color: MyColors.defaultColor,
        ),
        child: content,
      ),
    );
  }
}

class _FutureElevatedButton extends StatefulWidget {
  const _FutureElevatedButton({
    required this.onPressed,
    this.tooltip,
    this.autofocus = false,
    this.style,
    required this.label,
    this.icon,
  });

  final FutureVoidCallback onPressed;
  final bool autofocus;
  final ButtonStyle? style;
  final String? tooltip;
  final Widget label;
  final Widget? icon;

  @override
  State<_FutureElevatedButton> createState() => _FutureElevatedButtonState();
}

class _FutureElevatedButtonState extends State<_FutureElevatedButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      await widget.onPressed();
    } catch (e) {
      rethrow;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) => _Child(
    onPressed: _isLoading ? null : _onPressed,
    label: widget.icon == null
        ? Stack(
            alignment: Alignment.center,
            children: [
              Opacity(opacity: .0, child: widget.label),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isLoading
                    ? _buildLoadingIndicator(context)
                    : widget.label,
              ),
            ],
          )
        : widget.label,
    autofocus: widget.autofocus,
    style: widget.style,
    tooltip: _isLoading ? 'Loading...' : widget.tooltip,
    icon: widget.icon == null
        ? null
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isLoading ? _buildLoadingIndicator(context) : widget.icon,
          ),
  );

  Widget _buildLoadingIndicator(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final applyTextScaling = iconTheme.applyTextScaling ?? false;
    final tentativeIconSize = iconTheme.size ?? kDefaultFontSize;
    final iconSize =
        ((applyTextScaling
                    ? MediaQuery.textScalerOf(context).scale(tentativeIconSize)
                    : tentativeIconSize) -
                2.0)
            .clamp(4.0, 16.0);
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: CupertinoActivityIndicator(
          color: widget.style?.foregroundColor?.resolve({}),
        ),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({
    required this.onPressed,
    this.tooltip,
    this.autofocus = false,
    this.style,
    required this.label,
    this.icon,
  });

  final VoidCallback? onPressed;
  final bool autofocus;
  final ButtonStyle? style;
  final String? tooltip;
  final Widget label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final content = ElevatedButton.icon(
      autofocus: autofocus,
      style: style,
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
    if (tooltip == null) return content;
    return Tooltip(message: tooltip, child: content);
  }
}
