//
// import 'package:emergencystore/utils/constants/colors.dart';
// import 'package:emergencystore/utils/constants/sizes.dart';
// import 'package:emergencystore/utils/helpers/helper_function.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// class TProductQuantityWithAddRemoveButton extends StatelessWidget {
//   const TProductQuantityWithAddRemoveButton({super.key, required this.quantity, this.add, this.remove});
//
//   final int quantity;
//   final VoidCallback? add,remove;
//   @override
//   Widget build(BuildContext context) {
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TCicularIcon(
//           icon: Iconsax.minus,
//           width: 32,
//           height: 32,
//           size: TSizes.md,
//           color: THelperFunctions.isDarkMode(context)
//               ? TColors.white
//               : TColors.black,
//           backgroundColor: THelperFunctions.isDarkMode(context)
//               ? TColors.darkGrey
//               : TColors.light,
//           onPressed: remove,
//         ),
//         const SizedBox(width: TSizes.spaceBtwItems),
//         Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
//         const SizedBox(width: TSizes.spaceBtwItems),
//         TCicularIcon(
//           icon: Iconsax.add,
//           width: 32,
//           height: 32,
//           size: TSizes.md,
//           color: TColors.white,
//           backgroundColor: TColors.primaryColor,
//           onPressed: add,
//         ),
//       ],
//     );
//   }
// }
