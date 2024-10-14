


import 'package:emergencystore/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class TCartCounterIcons extends StatelessWidget {
  const TCartCounterIcons({
    super.key,
    this.iconColor = TColors.darkerGrey,
    required this.onPressed,
  });
  final Color? iconColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Iconsax.shopping_bag, color: Colors.white,)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: TColors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
                child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontSizeFactor: 0.8))),
          ),
        )
      ],
    );
  }
}