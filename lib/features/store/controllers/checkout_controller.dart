// import 'package:etrade_actions/common/widgets/payment_tile/payment_tile.dart';
// import 'package:etrade_actions/features/shop/models/payment_model.dart';
// import 'package:etrade_actions/features/shop/screens/home/widgets/TSectionHeading.dart';
// import 'package:etrade_actions/utils/constants/image_strings.dart';
// import 'package:etrade_actions/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CheckoutController extends GetxController {
//   static CheckoutController get instance => Get.find();
//
//   final Rx<PaymentMethodModel> selectedPaymentMethod =
//       PaymentMethodModel.empty().obs;
//
//   @override
//   void onInit() {
//     selectedPaymentMethod.value =
//         PaymentMethodModel(name: 'PayPal', image: TImages.paypal);
//     super.onInit();
//   }
//
//   Future<dynamic> selectPaymentMethod(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) => SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(TSizes.lg),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const TSectionHeading(
//                   title: 'Select Payment Method', showActionsButton: false),
//               const SizedBox(height: TSizes.spaceBtwSections),
//               TPaymentTile(
//                 paymentMethod:
//                     PaymentMethodModel(name: 'PayPal', image: TImages.paypal),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod: PaymentMethodModel(
//                     name: 'Google Pay', image: TImages.googlePay),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod: PaymentMethodModel(
//                     name: 'Credit Card', image: TImages.creditCard),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod:
//                     PaymentMethodModel(name: 'VISA', image: TImages.visa),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod: PaymentMethodModel(
//                     name: 'Apple Pay', image: TImages.applePay),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod: PaymentMethodModel(
//                     name: 'Master Card', image: TImages.masterCard),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod:
//                     PaymentMethodModel(name: 'Paytm', image: TImages.paytm),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//               TPaymentTile(
//                 paymentMethod: PaymentMethodModel(
//                     name: 'Paystack', image: TImages.paystack),
//               ),
//               const SizedBox(height: TSizes.spaceBtwItems / 2),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
