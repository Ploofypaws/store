
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';

class TStoreSearch extends StatelessWidget {
  const TStoreSearch({
    super.key,
    this.icon = Iconsax.search_normal,
    required this.displayText,
    this.showBorderColor = true,
    this.showBackground = true,
    required this.onTap,
    required this.padding,
  });

  final IconData? icon;
  final String displayText;
  final bool showBorderColor, showBackground;
  final EdgeInsetsGeometry padding;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? Colors.white
                : TColors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
            border:
            showBorderColor ? Border.all(color: TColors.borderPrimary) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: TColors.textSecondary,
              ),
              const SizedBox(width: TSizes.md),
              Text(
                displayText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: TColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}