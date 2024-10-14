class CartItem {
  final String title;
  final String description;
  final String price;
  final String image;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
