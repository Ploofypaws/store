import 'package:flutter/material.dart';
class tCircularContainer extends StatelessWidget {
  const tCircularContainer({
    super.key, this.width, this.height, this.radius, this.padding, this.child, required this.backgroundColor,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double?  padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: backgroundColor
      ),
      child: child,
    );
  }
}
