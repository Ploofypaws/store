// import 'package:etrade_actions/common/widgets/loaders/loaders.dart';
// import 'package:etrade_actions/features/shop/controllers/variation_controller.dart';
// import 'package:etrade_actions/features/shop/models/cart_item_model.dart';
// import 'package:etrade_actions/features/shop/models/product_model.dart';
// import 'package:etrade_actions/utils/constants/enums.dart';
// import 'package:etrade_actions/utils/local_storage/storage_utility.dart';
// import 'package:get/get.dart';
//
// class CartController extends GetxController {
//   static CartController get instance => Get.find();
//
//   RxInt noOfCartItems = 0.obs;
//   RxDouble totalCartPrice = 0.0.obs;
//   RxInt productQuantityInCart = 0.obs;
//   RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
//   final variationController = Get.put(VariationController());
//
//   CartController() {
//     loadCartItems();
//   }
//   void addToCart(ProductModel productModel) {
//     if (productQuantityInCart.value < 1) {
//       TLoaders.customToast(message: 'Select Quantity');
//       return;
//     }
//
//     if (productModel.productType == ProductType.variable.toString() &&
//         variationController.selectedVariation.value.id.isEmpty) {
//       TLoaders.customToast(message: 'Select Variation');
//       return;
//     }
//
//     if (productModel.productType == ProductType.variable.toString()) {
//       if (variationController.selectedVariation.value.stock < 1) {
//         TLoaders.warningSnackBar(
//             message: 'Selected variation is out of stock', title: 'Oh snap!');
//       }
//     } else {
//       if (productModel.stock < 1) {
//         TLoaders.warningSnackBar(
//             message: 'Product is out of stock', title: 'Oh snap!');
//       }
//     }
//
//     final selectedCartItem =
//         convertToCartItem(productModel, productQuantityInCart.value);
//
//     int index = cartItems.indexWhere((cartItem) =>
//         cartItem.productId == selectedCartItem.productId &&
//         cartItem.variationId == selectedCartItem.variationId);
//     if (index >= 0) {
//       cartItems[index].quantity = selectedCartItem.quantity;
//     } else {
//       cartItems.add(selectedCartItem);
//     }
//
//     updateCart();
//     TLoaders.customToast(message: 'Your product has been added to the cart.');
//   }
//
//   void addOneToCart(CartItemModel itemModel) {
//     int index = cartItems.indexWhere((cartItem) =>
//         cartItem.productId == itemModel.productId &&
//         cartItem.variationId == itemModel.variationId);
//
//     if (index >= 0) {
//       cartItems[index].quantity += 1;
//     } else {
//       cartItems.add(itemModel);
//     }
//
//     updateCart();
//   }
//
//   void removeOneFromCart(CartItemModel cartItemModel) {
//     int index = cartItems.indexWhere((cartItem) =>
//         cartItem.productId == cartItemModel.productId &&
//         cartItem.variationId == cartItemModel.variationId);
//
//     if (index >= 0) {
//       if (cartItems[index].quantity > 1) {
//         cartItems[index].quantity -= 1;
//       } else {
//         cartItems.removeAt(index);
//       }
//     }
//
//     updateCart();
//   }
//
//   void removeFromCartDialog(int index) {
//     Get.defaultDialog(
//         title: 'Remove product',
//         middleText:
//             'Are you sure you want to remove this product from the cart?',
//         onConfirm: () {
//           cartItems.removeAt(index);
//           updateCart();
//           TLoaders.customToast(message: 'Product removed from cart');
//           Get.back();
//         },
//         onCancel: () => () => Get.back());
//   }
//
//   CartItemModel convertToCartItem(ProductModel productModel, int quantity) {
//     if (productModel.productType == ProductType.single.toString()) {
//       variationController.resetSelectedAttributes();
//     }
//
//     final variation = variationController.selectedVariation.value;
//     final isVariation =
//         variationController.selectedVariation.value.id.isNotEmpty;
//     final price = isVariation
//         ? variation.salePrice > 0.0
//             ? variation.salePrice
//             : variation.price
//         : productModel.salePrice > 0.0
//             ? productModel.salePrice
//             : productModel.price;
//
//     return CartItemModel(
//       productId: productModel.id,
//       title: productModel.title,
//       price: price,
//       variationId: variation.id,
//       image: isVariation ? variation.image : productModel.thumbnail,
//       brandName: productModel.brand!.name,
//       quantity: quantity,
//       selectedVariation: isVariation ? variation.attributeValues : null,
//     );
//   }
//
//   void updateCart() {
//     updateCartTotals();
//     saveCartItems();
//     cartItems.refresh();
//   }
//
//   void updateCartTotals() {
//     double calculatedTotalPrice = 0.0;
//     int calculatedNoOfCartItems = 0;
//
//     for (var item in cartItems) {
//       calculatedTotalPrice += (item.price) * item.quantity.toDouble();
//       calculatedNoOfCartItems += item.quantity;
//     }
//
//     totalCartPrice.value = calculatedTotalPrice;
//     noOfCartItems.value = calculatedNoOfCartItems;
//   }
//
//   void saveCartItems() {
//     final cartItemsJson =
//         cartItems.map((cartItem) => cartItem.toJson()).toList();
//     TLocalStorage.instance().saveData('cartItems', cartItemsJson);
//   }
//
//   void loadCartItems() {
//     final cartItemsStrings =
//         TLocalStorage.instance().readData<List<dynamic>>('cartItems');
//     if (cartItemsStrings != null) {
//       cartItems.assignAll(cartItemsStrings
//           .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
//       updateCart();
//     }
//   }
//
//   int getProductQuantityInCart(String productId) {
//     final foundItem = cartItems
//         .where((item) => item.productId == productId)
//         .fold(0, (previousValue, element) => previousValue + element.quantity);
//     return foundItem;
//   }
//
//   int getVariationQuantityInCart(String productId, String variationId) {
//     final foundItem = cartItems.firstWhere(
//         (item) =>
//             item.productId == productId && item.variationId == variationId,
//         orElse: () => CartItemModel.empty());
//     return foundItem.quantity;
//   }
//
//   void clearCart() {
//     productQuantityInCart.value = 0;
//     cartItems.clear();
//     updateCart();
//   }
//
//   void updateAlreadyAddedProductCount(ProductModel product) {
//     if (product.productType == ProductType.single.toString()) {
//       productQuantityInCart.value = getProductQuantityInCart(product.id);
//     } else {
//       // Get selected Variation if any...
//       final variationId = variationController.selectedVariation.value.id;
//       if (variationId.isNotEmpty) {
//         productQuantityInCart.value =
//             getVariationQuantityInCart(product.id, variationId);
//       } else {
//         productQuantityInCart.value = 0;
//       }
//     }
//   }
// }
