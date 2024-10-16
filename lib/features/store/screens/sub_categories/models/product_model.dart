import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String category;
  final String description;
  final String price;
  final String sub;
  final String url;

  Product(
      {required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.sub,
      this.url =
          'https://images.unsplash.com/photo-1668114844900-537ab91478b9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'});

  // Factory method to create a Product instance from a Firestore document snapshot
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '0',
      sub: data['sub'] ?? '',
    );
  }
}
