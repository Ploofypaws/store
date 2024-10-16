import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/common/widgets/layouts/grid_layout.dart';
import 'package:emergencystore/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:emergencystore/features/store/screens/sub_categories/models/product_model.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key, required this.title});
  final String title;

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Product> subProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('sub', isEqualTo: widget.title)
          .get();

      List<Product> fetchedProducts = snapshot.docs.map((doc) {
        return Product.fromFirestore(doc); // Map each document to ProductModel
      }).toList();

      setState(() {
        subProducts = fetchedProducts; // Update the UI with fetched products
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TGridLayout(
        itemCount: subProducts.length,
        itemBuilder: (_, index) => TProductCardVertical(
          url: subProducts[index].url,
          title: subProducts[index].name,
          price: subProducts[index].price,
        ),
      ),
    );
  }
}
