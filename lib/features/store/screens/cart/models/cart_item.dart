class CartItem {
  final String title;
  final String description;
  final String price;
  final String image;
  int quantity; // New field for quantity

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1, // Default quantity is 1
  });

  // Convert CartItem to a Map
  Map<String, String> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'quantity': quantity.toString(),
    };
  }

  // Create CartItem from a Map
  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      title: map['title'],
      description: map['description'],
      price: map['price'],
      image: map['image'],
      quantity: int.parse(map['quantity']),
    );
  }
}
