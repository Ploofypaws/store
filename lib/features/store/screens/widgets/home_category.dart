import 'package:emergencystore/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:emergencystore/features/store/screens/sub_categories/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class THomeCategory extends StatelessWidget {
  const THomeCategory({
    super.key,
  });

  // List of icon paths and titles for the categories
  final List<Map<String, String>> categories = const [
    {'icon': TImages.bagpackIcon, 'title': 'Bagpack'},
    {'icon': TImages.campIcon, 'title': 'Camp'},
    {'icon': TImages.fireIcon, 'title': 'Fire'},
    {'icon': TImages.glovesIcon, 'title': 'Gloves'},
    {'icon': TImages.medikitIcon, 'title': 'Medikit'},
    {'icon': TImages.shoesIcon, 'title': 'Shoes'},
    {'icon': TImages.torchIcon, 'title': 'Torch'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return TVerticalImageText(
            image: category['icon']!, // Image path from the category list
            title: category['title']!, // Title from the category list
            onTap: () => Get.to(() => SubCategoriesScreen(
              category: category['title']!, // Pass category title to the screen
            )),
          );
        },
      ),
    );
  }
}
