
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TGridViewLayout extends StatelessWidget {
  const TGridViewLayout({super.key, required this.itemCount, this.mainAxisExtent = 296, required this.itemBuilder});

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}