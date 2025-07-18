import 'package:flutter/material.dart';

import '../enums/currency.dart';
import '../resources/colors.dart';

/// CreateDate: 2025/7/16 10:43
/// Author: Lee
/// Description:

InlineSpan productPriceStyle({Currency? currency, double? price}) =>
    priceStyle(price: price, currency: currency, color: MyColors.defaultColor);

InlineSpan balanceStyle({Currency? currency, double? price}) =>
    priceStyle(price: price, currency: currency, fontSize: 20.0);

InlineSpan purchasePriceStyle({Currency? currency, double? price}) =>
    priceStyle(
      price: price,
      currency: currency,
      color: MyColors.defaultColor,
      fontSize: 20.0,
    );

InlineSpan priceStyle({
  Currency? currency,
  double? price,
  Color color = Colors.green,
  double fontSize = 18.0,
}) {
  final mainStyle = TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
  );
  final appendStyle = mainStyle.copyWith(fontSize: fontSize - 6.0);
  const emptySpan = TextSpan(text: '--');
  return TextSpan(
    children: currency == null
        ? [emptySpan]
        : [
            TextSpan(text: '${currency.symbol} '),
            if (price?.toStringAsFixed(2).split('.') case [
              final String intPart,
              final String decPart,
            ]) ...[
              TextSpan(text: '$intPart.', style: mainStyle),
              TextSpan(text: decPart),
            ] else
              emptySpan,
          ],
    style: appendStyle,
  );
}
