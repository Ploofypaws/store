import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/common/widgets/icons/t_circular_icon.dart';
import 'package:emergencystore/common/widgets/layouts/grid_layout.dart';
import 'package:emergencystore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add,
              onPressed: () => Get.offAll(const NavigationMenu())),
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TGridLayout(
            itemCount: 4,
            itemBuilder: (_, index) => TProductCardVertical(
              title: 'Something',
              price: '0',
              url:
                  'https://imgs.search.brave.com/Gc-zjR3S-X5YqDGlcYNXG3Ly4sT8i8NFeEivMVHFmcI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMuaW5kZXBlbmRl/bnQuY28udWsvMjAy/Mi8wNy8xNS8wOS9N/YWdsaXRlJTIwTUwx/NTBMUlglMjByZWNo/YXJnZWFibGUlMjB0/b3JjaC5qcGc',
            ),
          )),
    );
  }
}
