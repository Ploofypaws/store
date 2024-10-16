
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width ,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.padding,
    this.child,
    this.backgroundColor = TColors.white,
    this.margin,
    this.showBorder = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  final double ? width;
  final double ? height;
  final double  radius;
  final EdgeInsets ? padding;
  final Widget ? child;
  final Color backgroundColor;
  final EdgeInsets ?  margin;
  final bool showBorder;
  final Color borderColor; // color of the border
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor, width: borderWidth) : null,
      ),
      child: child,

    );
  }
}