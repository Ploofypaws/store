
import 'package:emergencystore/common/brands/brand_name.dart';
import 'package:emergencystore/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:emergencystore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/custom_shapes/circular_container.dart';
import '../../../../common/widgets/custom_shapes/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/tabs.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            'Store',style: TextStyle(color: Colors.white),

          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: TCartCounterIcons(onPressed: () {}, iconColor: Colors.black),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      // Search bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSearchContainer(
                        text: 'Search in store',
                        showBorder: true,
                        showBackground: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Featured brands
                      TSectionHeading(
                        title: "Featured Brands",
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 88,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: TCircularContainer(
                              height: 56,
                              width: 56,
                              radius: 10,
                              padding: const EdgeInsets.all(TSizes.sm),
                              showBorder: true,
                              borderColor: TColors.lightGrey,
                              backgroundColor: Colors.transparent,
                              child: Row(
                                children: [
                                  // Icon
                                  Flexible(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(TSizes.sm),
                                      decoration: BoxDecoration(
                                        color:
                                        THelperFunctions.isDarkMode(context)
                                            ? TColors.black
                                            : TColors.white,
                                        borderRadius:
                                        BorderRadius.circular(100),
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
                                                'Abcd',
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
                                                color: Colors.blue,
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
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Tabs

                bottom: const TBottomBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'hiking',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'safety',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'trekking',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'house',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'essentials',
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: const TabBarView(
            children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Brands
              const TBrandShowcase(
                images: [
                  TImages.torchIcon,
                  TImages.bagpackIcon,
                  TImages.campIcon,
                ],
              ),
              const TBrandShowcase(
                images: [
                  TImages.productImageLap1,
                  TImages.shoesIcon,
                  TImages.glovesIcon,
                ],
              ),

              //Products
              TSectionHeading(title: 'You might like',onPressed: (){},),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TGridLayout(itemCount: 4, itemBuilder: (_,context) => const TProductCardVertical()),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              )
            ],
          ),
        ),
        ]
    );
  }
}
