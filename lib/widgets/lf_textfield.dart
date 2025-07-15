import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// CreateDate: 2025/7/15 15:00
/// Author: Lee
/// Description:

class LFTextField extends StatelessWidget {
  const LFTextField({
    super.key,
    this.autoFocus = false,
    this.hintText,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.focusNode,
    this.enabled,
    this.suffix,
    this.mouseCursor,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.errorText,
    this.restorationId,
    this.expands = false,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.buildCounter,
    this.prefix,
    this.prefixConstraints,
    this.suffixConstraints = const BoxConstraints.tightFor(
      width: 32.0,
      height: 16.0,
    ),
    this.suffixPadding = const EdgeInsets.only(right: 12.0),
    this.textInputAction,
    this.obscureText = false,
    this.autofillHints = const [],
  });

  final bool autoFocus;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool? enabled;
  final MouseCursor? mouseCursor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? errorText;
  final String? restorationId;
  final bool expands;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final InputCounterWidgetBuilder? buildCounter;
  final Widget? prefix;
  final Widget? suffix;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final EdgeInsetsGeometry suffixPadding;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) => TextField(
    autofocus: autoFocus,
    controller: controller,
    onSubmitted: onSubmitted,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onTap: onTap,
    focusNode: focusNode,
    enabled: enabled,
    mouseCursor: mouseCursor,
    inputFormatters: inputFormatters,
    maxLines: maxLines,
    minLines: minLines,
    maxLength: maxLength,
    restorationId: restorationId,
    expands: expands,
    keyboardType: keyboardType,
    textAlign: textAlign,
    buildCounter: buildCounter,
    textInputAction: textInputAction,
    obscureText: obscureText,
    autofillHints: autofillHints,
    decoration: InputDecoration(
      hintText: hintText,
      errorText: errorText,
      prefixIcon: prefix,
      suffixIcon: suffix == null
          ? null
          : IconTheme.merge(
              data: const IconThemeData(size: 16.0),
              child: Padding(padding: suffixPadding, child: suffix),
            ),
      prefixIconConstraints: prefixConstraints,
      suffixIconConstraints: suffixConstraints,
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}
