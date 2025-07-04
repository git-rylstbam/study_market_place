import 'package:flutter/material.dart';

/// CreateDate: 2025/7/4 17:38
/// Author: Lee
/// Description:

class LFLabelTextField extends StatelessWidget {
  const LFLabelTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.autofillHints = const <String>[],
    this.labelText,
    this.obscureText = false,
    this.onSubmitted,
    this.onChanged,
    this.textInputAction,
    this.autofocus = false,
    this.enabled,
    this.maxLength,
    this.suffixIcon,
    this.errorText,
    this.hintText,
    this.readOnly = false,
    this.expands = false,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? labelText;
  final bool obscureText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool? enabled;
  final int? maxLength;
  final Widget? suffixIcon;
  final String? errorText;
  final String? hintText;
  final bool readOnly;
  final bool expands;
  final int? maxLines;

  @override
  Widget build(BuildContext context) => TextField(
    autofillHints: autofillHints,
    focusNode: focusNode,
    controller: controller,
    obscureText: obscureText,
    textInputAction: textInputAction,
    autofocus: autofocus,
    enabled: enabled,
    maxLength: maxLength,
    buildCounter:
        (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) => null,
    expands: expands,
    maxLines: maxLines,
    decoration: InputDecoration(
      isDense: false,
      labelText: labelText,
      contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 14.0),
      suffixIcon: suffixIcon,
      errorText: errorText,
      hintText: hintText,
      alignLabelWithHint: true,
    ),
    onSubmitted: onSubmitted,
    onChanged: onChanged,
    readOnly: readOnly,
  );
}

class LFObscureLabelTextField extends StatefulWidget {
  const LFObscureLabelTextField({
    super.key,
    this.obscureTextNotifier,
    this.controller,
    this.autofillHints,
    this.labelText,
    this.textInputAction,
    this.onSubmitted,
  });

  final ValueNotifier<bool>? obscureTextNotifier;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;
  final String? labelText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<LFObscureLabelTextField> createState() =>
      _LFObscureLabelTextFieldState();
}

class _LFObscureLabelTextFieldState extends State<LFObscureLabelTextField> {
  ValueNotifier<bool>? _obscureTextNotifier;

  ValueNotifier<bool> get _effectiveController =>
      widget.obscureTextNotifier ?? _obscureTextNotifier!;

  @override
  void initState() {
    super.initState();
    if (widget.obscureTextNotifier == null) {
      _obscureTextNotifier = ValueNotifier(true);
    }
  }

  @override
  void didUpdateWidget(LFObscureLabelTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureTextNotifier == null &&
        oldWidget.obscureTextNotifier != null) {
      _obscureTextNotifier = ValueNotifier(true);
    } else if (widget.obscureTextNotifier != null &&
        oldWidget.obscureTextNotifier == null) {
      _obscureTextNotifier!.dispose();
      _obscureTextNotifier = null;
    }
  }

  @override
  void dispose() {
    _obscureTextNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: _effectiveController,
    builder: (context, obscureText, _) => LFLabelTextField(
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      labelText: widget.labelText,
      obscureText: obscureText,
      textInputAction: widget.textInputAction,
      maxLength: 20,
      onSubmitted: widget.onSubmitted,
      suffixIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: IconButton(
          onPressed: () => _effectiveController.value = !obscureText,
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            size: 18.0,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
        ),
      ),
    ),
  );
}
