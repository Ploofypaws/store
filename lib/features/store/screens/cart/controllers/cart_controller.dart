import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/features/store/screens/cart/models/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // Observable list of cart items

  Future<void> addToCart(CartItem newItem) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Check if item already exists in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.title == newItem.title &&
        cartItem.description == newItem.description);

    if (index != -1) {
      // If item exists, increment the quantity
      cartItems[index].quantity++;
    } else {
      // If item doesn't exist, add it to the cart
      cartItems.add(newItem);
    }

    // Update Firestore with the updated cart
    List<Map<String, String>> updatedCart =
        cartItems.map((item) => item.toMap()).toList();
    await userDocRef.update({'cartItems': updatedCart});
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Find the index of the cart item in the local list
    final existingItemIndex = cartItems.indexWhere(
      (item) =>
          item.title == cartItem.title &&
          item.description == cartItem.description &&
          item.price == cartItem.price &&
          item.image == cartItem.image,
    );

    if (existingItemIndex != -1) {
      CartItem existingItem = cartItems[existingItemIndex];

      // Get the quantity
      int quantity = existingItem.quantity;

      if (quantity > 1) {
        // If quantity is more than 1, decrement the quantity
        existingItem.quantity -= 1;

        // Update the local cart
        cartItems[existingItemIndex] = existingItem;

        List<Map<String, String>> updatedCart =
            cartItems.map((item) => item.toMap()).toList();
        await userDocRef.update({'cartItems': updatedCart});
      } else {
        // If quantity is 1, remove the item from both local and Firestore
        cartItems.removeAt(existingItemIndex);

        await userDocRef.update({
          'cartItems': FieldValue.arrayRemove([existingItem.toMap()]),
        });
      }
    }
  }

  double get totalCartPrice {
    return cartItems.fold(
        0, (sum, item) => sum + double.parse(item.price) * item.quantity);
  }

  // Fetch cart items from Firestore and update cartItems
  Future<void> fetchCartItems() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the user document
      DocumentSnapshot userDoc = await userDocRef.get();

      // Check if the document exists
      if (userDoc.exists) {
        // Use the null-aware operator to safely access 'cartItems'
        List<dynamic> cartItemsFromFirestore = userDoc['cartItems'] ?? [];

        // Map the fetched items to your CartItem model
        cartItems.value = cartItemsFromFirestore
            .map((cartItemMap) => CartItem.fromMap(cartItemMap))
            .toList();
      } else {
        print("User document does not exist.");
        // Optionally initialize cartItems to an empty list
        cartItems.value = [];
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      // Optionally handle errors (e.g., show a notification to the user)
    }
  }
}
