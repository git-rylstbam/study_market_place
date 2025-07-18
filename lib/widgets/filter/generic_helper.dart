import 'package:flutter/widgets.dart';

/// CreateDate: 2025/7/16 17:42
/// Author: Lee
/// Description:

/// *** 为什么[T]不同于[V]? ***
///
/// 由于[ValueNotifier]的泛型类型可能是[Iterable]/[T]，但是我们实际需要的是类型[T]
mixin NotifierGenericHelper<T, V> on ChangeNotifier {
  V get value;

  set value(V newValue);

  Type get genericType => T;

  List<T?> get genericList => <T?>[];

  bool genericIsSubtypeOf<D>() => genericList is List<D?>;

  void clear();
}

class NotifierGenericHelperBuilder<T> extends StatefulWidget {
  const NotifierGenericHelperBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
  });

  final NotifierGenericHelper<dynamic, T> valueListenable;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;

  @override
  State<NotifierGenericHelperBuilder> createState() =>
      _NotifierGenericHelperBuilderState<T>();
}

class _NotifierGenericHelperBuilderState<T>
    extends State<NotifierGenericHelperBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(NotifierGenericHelperBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      value = widget.valueListenable.value;
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() => setState(() => value = widget.valueListenable.value);

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, value, widget.child);
}
