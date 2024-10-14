//
// import 'package:emergencystore/common/widgets/product_prices/product_price_text.dart';
// import 'package:emergencystore/features/store/screens/checkout/widgets/product_quantity.dart';
// import 'package:emergencystore/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TCartItems extends StatelessWidget {
//   const TCartItems({super.key, this.showAddRemoveButtons = true});
//   final bool showAddRemoveButtons;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = CartController.instance;
//     return Obx(
//       () => ListView.separated(
//         shrinkWrap: true,
//         itemCount: controller.cartItems.length,
//         separatorBuilder: (_, __) => SizedBox(
//           height: TSizes.spaceBtwSections,
//         ),
//         itemBuilder: (_, index) => Obx(() {
//           final item = controller.cartItems[index];
//           return Column(
//             children: [
//               TCartItem(cartItemModel: controller.cartItems[index]),
//               if (showAddRemoveButtons)
//                 const SizedBox(height: TSizes.spaceBtwItems),
//               if (showAddRemoveButtons)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const SizedBox(width: 70),
//                         TProductQuantityWithAddRemoveButton(quantity: item.quantity, add: () => controller.addOneToCart(item), remove: () => controller.removeOneFromCart(item),),
//                       ],
//                     ),
//                     TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1), fontSize: 12,),
//                   ],
//                 )
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
