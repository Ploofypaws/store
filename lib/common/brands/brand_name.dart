
import 'package:emergencystore/common/widgets/custom_shapes/circular_container.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';


class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TCircularContainer(

      radius: 10,
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          // Brand with product count
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                // Icon
                Flexible(
                  child: Container(

                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(TSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Image(
                      image: AssetImage(TImages.torchIcon),
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),

                // TExt
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 3.5, left: 5),
                        child: Row(
                          children: [
                            Text(
                              'Torch',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Iconsax.verify5,
                              color: TColors.primaryColor,
                              size: TSizes.iconXs,
                            )
                          ],
                        ),
                      ),
                      Text(
                        '256 Products',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // brand top 3 product images
          Row(
              children:
              (images.map((image) => brandTopProductImageWidget(image, context))).toList()

          )
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context){
  return Expanded(
    child: TCircularContainer(
      height: 90,
      width: 70,
      radius: 10,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
      margin: const EdgeInsets.only(right: TSizes.sm),
      child: Image(image: AssetImage(image), fit: BoxFit.contain,),
    ),
  );
}