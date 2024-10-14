import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:emergencystore/features/store/screens/checkout/widgets/billing_amount_section.dart';
import 'package:emergencystore/features/store/screens/checkout/widgets/billing_payment_section.dart';
import 'package:emergencystore/features/store/screens/checkout/widgets/billing_address_section.dart';

import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hardcoded values for subtotal and total amounts
    final bool darkMode = Theme.of(context).brightness == Brightness.dark;
    final double subTotal = 200.00; // Hardcoded subtotal value
    final double totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [

              const SizedBox(height: TSizes.spaceBtwSections),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: darkMode ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    // Pricing

                    SizedBox(height: TSizes.spaceBtwItems),

                    // Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Payment methods


                    // Billing Address
                    TBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => print('Processing order with total: \$${totalAmount}')
              : () => print('Empty Cart: Add items to proceed.'),
          child: Text('Checkout \$${totalAmount.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
