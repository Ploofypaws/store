import 'package:emergencystore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:emergencystore/common/widgets/texts/section_heading.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class PaymentMethod {
  final String name;
  final String image;

  PaymentMethod({required this.name, required this.image});
}

class TBillingPaymentSection extends StatelessWidget {
  final PaymentMethod selectedPaymentMethod;
  final VoidCallback onChangeMethod;

  const TBillingPaymentSection({
    super.key,
    required this.selectedPaymentMethod,
    required this.onChangeMethod,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        // Payment Method Section Heading
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change Method', onPressed: () {  },

        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Display selected payment method
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: Image(
                image: AssetImage(selectedPaymentMethod.image),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(
              selectedPaymentMethod.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
