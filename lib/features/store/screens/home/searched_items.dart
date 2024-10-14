import 'package:emergencystore/features/store/product/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:get/get_core/src/get_main.dart';

class ProductSearchScreen extends StatelessWidget {
  final String searchQuery;
  final List<String> categories = ["Torch", "Handles", "Camera"];
  final List<String> productNames = [
    "Torch ABC-100",
    "Torch XYZ-200",
    "Torch 123-400",
    "Handles - Pro",
    "Camera - Z",
    "Torch - Super"
  ];

  ProductSearchScreen({super.key, required this.searchQuery});

  List<String> _filterProducts(String query) {
    return productNames.where((product) => product.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<String> _getRandomProducts() {
    // Generate a random selection of products if no results match
    Random random = Random();
    return List<String>.generate(3, (index) => productNames[random.nextInt(productNames.length)]);
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredProducts = _filterProducts(searchQuery);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for anything...',
                                prefixIcon: const Icon(Icons.search, color: Colors.black),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(12.0),
                              ),
                              onChanged: (value) {
                                // Optional: Implement filtering logic if needed
                              },
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(

                        filteredProducts.isNotEmpty
                            ? "Showing results for ‘$searchQuery’"
                            : "No results found for ‘$searchQuery’",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: categories.map((category) {
                      return ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          backgroundColor: category == "Torch" ? Colors.redAccent : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: category == "Torch" ? Colors.redAccent.shade200 : Colors.grey.shade200,
                          elevation: category == "Torch" ? 8 : 2,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              category == "Torch"
                                  ? Icons.flash_on
                                  : category == "Handles"
                                  ? Icons.accessibility
                                  : Icons.camera_alt,
                              color: category == "Torch" ? Colors.white : Colors.black87,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              category,
                              style: TextStyle(
                                color: category == "Torch" ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: filteredProducts.isNotEmpty
                      ? _buildProductList(filteredProducts)
                      : _buildNoResults(),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: Colors.black,
                label: const Text(
                  "SORT",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                icon: const Icon(Icons.sort, color: Colors.white),
                elevation: 5,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: Colors.redAccent,
                label: const Text(
                  "FILTER",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.filter_list),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<String> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(onTap:() =>Get.to(() =>  ProductDetailPage()),child: ProductCard(productName: products[index])),
        );
      },
    );
  }

  Widget _buildNoResults() {
    List<String> randomProducts = _getRandomProducts();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "No results found.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
        Expanded(
          child: _buildProductList(randomProducts),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;

  const ProductCard({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "\$379.00",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border_outlined),
                  onPressed: () {},
                  color: Colors.black,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Buy",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
