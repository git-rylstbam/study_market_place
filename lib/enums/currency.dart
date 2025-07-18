import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/16 10:44
/// Author: Lee
/// Description:

@JsonEnum()
enum Currency {
  CNY('¥'),
  USD(r'$'),
  IDR('Rp'),
  GBP('£'),
  EUR('€'),
  JPY('Ұ'),
  TWD(r'NT$');

  const Currency(this.symbol);

  final String symbol;

  @override
  String toString() => '$name ( $symbol )';

  String toJson() => name;
}
