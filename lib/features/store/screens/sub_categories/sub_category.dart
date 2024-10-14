import 'package:emergencystore/features/store/screens/widgets/promo_slider.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final String category; // Changed to simple String for demo purposes

  @override
  Widget build(BuildContext context) {
    // Example data for subcategories and products
    final List<String> subCategories = ['SubCategory 1', 'SubCategory 2'];
    final List<String> products = ['Product 1', 'Product 2', 'Product 3'];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Simplified padding
          child: Column(
            children: [
              // Example banner image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // image: const DecorationImage(
                  //   image: AssetImage('assets/images/banner5.jpg'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: TPromoSlide(banner: [
                  TImages.promoBanner1,
                  TImages.promoBanner2,
                  TImages.promoBanner3,
                  TImages.promoBanner4
                ]),
              ),
              const SizedBox(height: 16),

              // List of subcategories and products
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = subCategories[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subcategory heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subCategory,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              // Simulated navigation to "All Products" screen
                              Get.to(
                                  () => AllProductsScreen(title: subCategory));
                            },
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Products list
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example AllProductsScreen for navigation
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('All products will be displayed here'),
      ),
    );
  }
}

// Example ProductCard widget
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final String product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Icon(Icons.shopping_bag, size: 40),
          const SizedBox(height: 8),
          Text(
            product,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
