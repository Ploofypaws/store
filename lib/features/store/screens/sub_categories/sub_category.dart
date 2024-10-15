import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/features/store/screens/widgets/promo_slider.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final String category;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  // Example data for subcategories and products
  List<String> subCategories = [];
  final List<String> products = ['Product 1', 'Product 2', 'Product 3'];

  @override
  void initState() {
    super.initState();
    _fetchSubCategories();
  }

  // Fetch subcategories from Firestore
  Future<void> _fetchSubCategories() async {
    try {
      print(widget.category);
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.category)
          .get();

      if (doc.exists && doc.data() != null) {
        // Check if 'sub' field exists and is a List
        List<dynamic>? fetchedSubCategories = doc['sub'];
        if (fetchedSubCategories != null) {
          setState(() {
            subCategories = fetchedSubCategories.cast<String>();
          });
        } else {
          print("Subcategories not found or invalid format.");
        }
      } else {
        print("Document does not exist!");
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
    }
  }

  // Changed to simple String for demo purposes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
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
