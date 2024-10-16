import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/common/widgets/products/product_card/product_card_horizontal.dart';
import 'package:emergencystore/features/store/screens/sub_categories/all_products.dart';
import 'package:emergencystore/features/store/screens/sub_categories/models/product_model.dart';
import 'package:emergencystore/features/store/screens/widgets/promo_slider.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final String category;

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List<String> subCategories = [];
  Map<String, List<Product>> subCategoryProducts =
      {}; // Store Product objects for each subcategory

  @override
  void initState() {
    super.initState();
    _fetchSubCategories();
  }

  // Fetch subcategories from Firestore
  Future<void> _fetchSubCategories() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('categories')
          .doc(widget.category)
          .get();

      if (doc.exists && doc.data() != null) {
        List<dynamic>? fetchedSubCategories = doc['sub'];
        if (fetchedSubCategories != null) {
          setState(() {
            subCategories = fetchedSubCategories.cast<String>();
          });
          _fetchProductsForSubCategories(); // Fetch products for each subcategory
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

  // Fetch products for each subcategory
  Future<void> _fetchProductsForSubCategories() async {
    try {
      for (String subCategory in subCategories) {
        QuerySnapshot productSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('sub', isEqualTo: subCategory)
            .get();

        List<Product> products = productSnapshot.docs
            .map((doc) => Product.fromFirestore(doc))
            .toList();

        setState(() {
          subCategoryProducts[subCategory] = products;
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              subCategories.isEmpty
                  ? const Center(
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        final subCategory = subCategories[index];
                        final products = subCategoryProducts[subCategory] ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subCategory,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() =>
                                        AllProductsScreen(title: subCategory));
                                  },
                                  child: const Text('View All'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: height * 0.14,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: TProductCardHorizontal(
                                      title: product.name,
                                      price: product.price,
                                    ),
                                  );
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

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         children: [
//           const Icon(Icons.shopping_bag, size: 40),
//           const SizedBox(height: 8),
//           Text(
//             product.name,
//             style: Theme.of(context).textTheme.bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             product.price,
//             style: Theme.of(context).textTheme.bodySmall,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// Example ProductCard widget
// class ProductCard extends StatelessWidget {
//   const ProductCard({super.key, required this.product});

//   final String product;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         children: [
//           const Icon(Icons.shopping_bag, size: 40),
//           const SizedBox(height: 8),
//           Text(
//             product,
//             style: Theme.of(context).textTheme.bodyMedium,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
