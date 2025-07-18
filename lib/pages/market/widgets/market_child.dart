import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mix/price_style.dart';
import '../../../resources/colors.dart';
import '../../../widgets/oss_image.dart';
import '../model/market_model.dart';
import '../page.dart';

/// CreateDate: 2025/7/16 9:46
/// Author: Lee
/// Description:

class MarketChild extends StatefulWidget {
  const MarketChild({super.key, required this.entity});

  final MarketEntity entity;

  @override
  State<MarketChild> createState() => _MarketChildState();
}

class _MarketChildState extends State<MarketChild>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 233),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.04).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {},
    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
    onHover: (value) => value ? _controller.forward() : _controller.reverse(),
    child: Container(
      width: kItemSize,
      height: kItemSize,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.defaultColor, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: kItemSize,
            height: kImageHeight,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            clipBehavior: Clip.antiAlias,
            child: widget.entity.imgUrl == null
                ? null
                : AnimatedBuilder(
                    animation: _animation,
                    builder: (_, __) => ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0 - _controller.value) * 12.0,
                      ),
                      child: Transform.scale(
                        scale: _animation.value,
                        child: LFImage.oss(
                          widget.entity.imgUrl!,
                          width: kItemSize,
                          height: kImageHeight,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: kDividerHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSize),
            child: SizedBox(
              height: kTitleHeight,
              child: Text(
                widget.entity.goodsName ?? '--',
                maxLines: 1,
                style: Get.textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSize),
            child: SizedBox(
              height: kPriceHeight,
              child: Text.rich(
                productPriceStyle(
                  currency: widget.entity.displayCurrency,
                  price: widget.entity.displayPrice,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
