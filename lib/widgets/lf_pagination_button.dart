import 'package:flutter/material.dart';

import '../resources/colors.dart';

/// CreateDate: 2025/7/17 16:32
/// Author: Lee
/// Description:

const _kBorderRadius = BorderRadius.all(Radius.circular(4.0));

class LFPaginationButton extends StatefulWidget {
  const LFPaginationButton({
    super.key,
    this.isSelected,
    this.onPressed,
    this.child,
    this.style,
  });

  final bool? isSelected;
  final void Function()? onPressed;
  final Widget? child;
  final TextStyle? style;

  bool get enabled => onPressed != null;

  @override
  State<LFPaginationButton> createState() => _LFPaginationButtonState();
}

class _LFPaginationButtonState extends State<LFPaginationButton>
    with MaterialStateMixin {
  @override
  void initState() {
    super.initState();
    setMaterialState(WidgetState.selected, widget.isSelected ?? false);
    setMaterialState(WidgetState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(LFPaginationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.selected, widget.isSelected ?? false);
    setMaterialState(WidgetState.disabled, !widget.enabled);
    if (isDisabled && isPressed) removeMaterialState(WidgetState.pressed);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = WidgetStateProperty.resolveAs<Color?>(
      widget.style?.color,
      materialStates,
    );
    const effectiveShape = RoundedRectangleBorder(borderRadius: _kBorderRadius);
    final effectiveMouseCursor = WidgetStateProperty.resolveAs<MouseCursor?>(
      WidgetStateMouseCursor.clickable,
      materialStates,
    );
    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 366),
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          borderRadius: _kBorderRadius,
          color: MyColors.defaultColor,
          // gradient: LinearGradient(
          //   colors: (widget.isSelected ?? false)
          //       ? [
          //           Theme.of(context).colorScheme.primary,
          //           Theme.of(context).colorScheme.secondary,
          //         ]
          //       : [MyColors.defaultColor, Colors.white],
          // ),
        ),
        child: Material(
          textStyle: widget.style?.copyWith(color: effectiveTextColor),
          type: MaterialType.transparency,
          shape: effectiveShape,
          child: InkWell(
            customBorder: effectiveShape,
            mouseCursor: effectiveMouseCursor,
            onFocusChange: updateMaterialState(WidgetState.focused),
            onHighlightChanged: updateMaterialState(WidgetState.pressed),
            onHover: updateMaterialState(WidgetState.hovered),
            onTap: widget.onPressed,
            child: IconTheme.merge(
              data: IconThemeData(color: effectiveTextColor),
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
