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
  HomeScreen({super.key});

  final List<Map<String, String>> new_arrivals = [
    {
      'name': 'torch',
      'url':
          'https://imgs.search.brave.com/Gc-zjR3S-X5YqDGlcYNXG3Ly4sT8i8NFeEivMVHFmcI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMuaW5kZXBlbmRl/bnQuY28udWsvMjAy/Mi8wNy8xNS8wOS9N/YWdsaXRlJTIwTUwx/NTBMUlglMjByZWNo/YXJnZWFibGUlMjB0/b3JjaC5qcGc',
      'price': '1500'
    },
    {
      'name': 'Shoes',
      'url':
          'https://imgs.search.brave.com/hMzx_j8j5KcKhM-3sAYffa8jjVd2RYG0ew0Ny0gcWIo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAxLzIxLzgxLzg2/LzM2MF9GXzEyMTgx/ODY3M182RUlENWlG/NzZWQ0NjNGFHT0xK/a2Q5NFBobmdncmUz/by5qcGc',
      'price': '1800'
    },
    {
      'name': 'Laptop Bag',
      'url':
          'https://imgs.search.brave.com/on44vpuSbJB6Oa9bMjJNWMx6EIBnX-ijPwtrTe_KSyI/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzE3VVJBaUszNEwu/anBn',
      'price': '6000'
    },
    {
      'name': 'Kitchen Gloves',
      'url':
          'https://imgs.search.brave.com/JEadCnmoqyGNAXcKePEfENsovdbXjGdcOAdPcm8LNmg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTgy/MjM4ODMwL3Bob3Rv/L3dpbnRlci1nbG92/ZXMuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTJqZ2RRb09U/VkpTQmRJRFBrSDV2/RVdyekhvQl9kMENC/OXJyZmJtNTN5Tm89',
      'price': '1600'
    },
    {
      'name': 'Kitchen Gloves',
      'url':
          'https://imgs.search.brave.com/_ZGuFyoQi1HB__D5ShEMCM3g15-hx9mchSiT2-5KiAo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NTE0eFBteXp2Zkwu/anBn',
      'price': '2500'
    },
    {
      'name': 'First-Aid kit',
      'url':
          'https://imgs.search.brave.com/JEadCnmoqyGNAXcKePEfENsovdbXjGdcOAdPcm8LNmg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTgy/MjM4ODMwL3Bob3Rv/L3dpbnRlci1nbG92/ZXMuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTJqZ2RRb09U/VkpTQmRJRFBrSDV2/RVdyekhvQl9kMENC/OXJyZmJtNTN5Tm89',
      'price': '1200'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ---> Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// ---> Appbar
                  SizedBox(height: TSizes.spaceBtwItems),
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// ---> searchBar
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSearchContainer(),
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
                  TSectionHeading(
                    title: 'Categories',
                    showActionButton: true,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  /// Categories
                  THomeCategory()
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlide(banner: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                      TImages.promoBanner4
                    ]),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    ///----> Heading
                    TSectionHeading(
                        title: 'New Arrivals',
                        showActionButton: true,
                        onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// ----> Popular Products
                    TGridLayout(
                      itemCount: new_arrivals.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                        url: new_arrivals[index]['url']!,
                        title: new_arrivals[index]['name']!,
                        price: new_arrivals[index]['price']!,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
