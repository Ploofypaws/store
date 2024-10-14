



import 'package:emergencystore/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:emergencystore/common/widgets/custom_shapes/search_container.dart';
import 'package:emergencystore/common/widgets/layouts/grid_layout.dart';
import 'package:emergencystore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:emergencystore/common/widgets/texts/section_heading.dart';
import 'package:emergencystore/features/store/screens/widgets/home_appbar.dart';
import 'package:emergencystore/features/store/screens/widgets/home_category.dart';
import 'package:emergencystore/features/store/screens/widgets/promo_slider.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/image_strings.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ---> Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// ---> Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// ---> searchBar
                  TSearchContainer(text: 'Search in store', ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// ---> categories <-----

                ],
              ),
            ),
            /// ----> Body Part
            const Padding(
              padding: EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Heading
                  TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.black,),
                  SizedBox(height: TSizes.spaceBtwItems),
                  /// Categories
                  THomeCategory()
                ],
              ),
            ),
            Padding(
                padding:  const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlide(banner: [TImages.promoBanner1,TImages.promoBanner2,TImages.promoBanner3,TImages.promoBanner4]),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    ///----> Heading
                    TSectionHeading(title: 'Popular Products',showActionButton: true, onPressed: (){}),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// ----> Popular Products
                    TGridLayout(itemCount: 6, itemBuilder: (_, index) =>  const TProductCardVertical()),


                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}








