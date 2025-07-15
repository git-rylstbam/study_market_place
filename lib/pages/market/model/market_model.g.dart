// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketEntity _$MarketEntityFromJson(Map<String, dynamic> json) => MarketEntity(
      goodsId: (json['goodsId'] as num?)?.toInt(),
      goodsName: json['countryCoverage'] as String?,
      imgUrl: json['goodsUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      userPrice: (json['userPrice'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      userCurrency: json['userCurrency'] as String?,
    );

Map<String, dynamic> _$MarketEntityToJson(MarketEntity instance) =>
    <String, dynamic>{
      'goodsId': instance.goodsId,
      'countryCoverage': instance.goodsName,
      'goodsUrl': instance.imgUrl,
      'price': instance.price,
      'userPrice': instance.userPrice,
      'currency': instance.currency,
      'userCurrency': instance.userCurrency,
    };
