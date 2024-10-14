import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class TBillingAmountSection extends StatelessWidget {
  // Dummy data for billing calculations
  final double subtotal;
  final String country;

  const TBillingAmountSection({
    super.key,
    required this.subtotal,
    this.country = 'US', // Default to 'US' for this example
  });

  @override
  Widget build(BuildContext context) {
    final shippingFee = TPricingCalculator.calculateShipppingCost(subtotal, country);
    final taxFee = TPricingCalculator.calculateTax(subtotal, country);
    final total = TPricingCalculator.calculateTotalPrice(subtotal, country);

    return Column(
      children: [
        // SubTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sub total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('\$$subtotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping fee',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('\$$shippingFee', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$taxFee', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Total Amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$$total', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
      ],
    );
  }
}
