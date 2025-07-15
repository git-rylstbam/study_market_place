import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// CreateDate: 2025/7/15 16:21
/// Author: Lee
/// Description:

part 'market_model.g.dart';

@JsonSerializable()
class MarketEntity {
  const MarketEntity({
    this.goodsId,
    this.goodsName,
    this.imgUrl,
    this.price,
    this.userPrice,
    this.currency,
    this.userCurrency,
  });

  factory MarketEntity.fromJson(Map<String, dynamic> json) =>
      _$MarketEntityFromJson(json);

  final int? goodsId;
  @JsonKey(name: 'countryCoverage')
  final String? goodsName;
  @JsonKey(name: 'goodsUrl')
  final String? imgUrl;
  final double? price;
  final double? userPrice;
  final String? currency;
  final String? userCurrency;

  String get displayPrice => userPrice?.toString() ?? price?.toString() ?? '--';

  String get displayCurrency => userCurrency ?? currency ?? '--';

  Map<String, dynamic> toJson() => _$MarketEntityToJson(this);

  @override
  String toString() => jsonEncode(this);
}
