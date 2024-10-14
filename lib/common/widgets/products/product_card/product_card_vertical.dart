import 'package:emergencystore/common/widgets/images/t_rounded_images.dart';
import 'package:emergencystore/features/store/product/product_details.dart';
import 'package:emergencystore/features/store/screens/cart/controllers/cart_controller.dart';
import 'package:emergencystore/features/store/screens/cart/models/cart_item.dart';

import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../product_prices/product_price_text.dart';
import '../../texts/product_title_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical(
      {super.key,
      required this.url,
      required this.title,
      this.seller = 'Some one',
      required this.price});
  final String url;
  final String title;
  final String seller;
  final String price;

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find<CartController>(); // Get the instance of CartController
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                      title: title,
                      seller: seller,
                      price: price,
                      url: url
                    )));
      },
      child: Container(
        width: 140, // Adjusted width for smaller size
        padding: const EdgeInsets.all(8), // Padding for the container
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Allow the column to take minimum space
          children: [
            AspectRatio(
              aspectRatio:
                  1, // Maintains a 1:1 aspect ratio for the image container
              child: TRoundedContainer(
                padding: const EdgeInsets.all(4), // Smaller padding
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(url),
                      fit: BoxFit.cover, // Ensure the image scales properly
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    ///-----> Sale Tag
                    Positioned(
                      top: 0,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          '20%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black, fontSizeFactor: 0.8),
                        ),
                      ),
                    ),

                    ///---> Favourite Icon Button
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(Iconsax.heart5, color: Colors.red, size: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            /// ----> Details
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: title, smallSize: true),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        seller,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 12), // Smaller text
                      ),
                      const SizedBox(width: 4),
                      const Icon(Iconsax.verify5,
                          color: TColors.primaryColor, size: 14),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            /// ----> Price and Add Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ----> Price
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: TProductPriceText(price: price, fontSize: 14),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    width: 28, // Adjusted width for smaller button
                    height: 28,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            cartController.addToCart(CartItem(
                                title: title,
                                description:
                                    'The product is good and best to use',
                                price: price,
                                image: url));
                          },
                          icon: Icon(Iconsax.add,
                              color: TColors.white, size: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
