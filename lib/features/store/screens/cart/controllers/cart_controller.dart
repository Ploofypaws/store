import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/features/store/screens/cart/models/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // Observable list of cart items

  Future<void> addToCart(CartItem item) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    Map<String, String> cartItem = item.toMap();

    await userDocRef.update({
      'cartItems': FieldValue.arrayUnion([cartItem])
    });

    // Update the local cartItems list
    cartItems.add(item);
  }

  Future<void> removeFromCart(CartItem item) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    Map<String, String> cartItem = item.toMap();

    await userDocRef.update({
      'cartItems': FieldValue.arrayRemove([cartItem])
    });

    // Update the local cartItems list
    cartItems.remove(item);
  }

  // Method to fetch cart data from Firestore and convert to List<CartItem>
  Future<void> fetchCartItems() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      List<dynamic> cartData = userSnapshot.data()!['cartItems'] ?? [];

      // Convert each Map<String, String> back to CartItem
      List<CartItem> fetchedItems = cartData.map((item) {
        return CartItem(
          title: item['title'] ?? '',
          description: item['description'] ?? '',
          price: item['price'] ?? '0.0',
          image: item['image'] ?? '',
        );
      }).toList();

      // Update the observable cartItems list
      cartItems.value = fetchedItems;
    }
  }

  double get totalCartPrice {
    return cartItems.fold(0, (sum, item) => sum + double.parse(item.price));
  }
}
