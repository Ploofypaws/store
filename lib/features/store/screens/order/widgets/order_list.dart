import 'package:emergencystore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';

class TOrderListItems extends StatelessWidget {
  final List<Order> orders; // Accept a list of orders

  const TOrderListItems({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      separatorBuilder: (_, index) => const SizedBox(height: TSizes.spaceBtwItems),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (_, index) {
        final order = orders[index];
        return TRoundedContainer(
          showBorder: true,
          backgroundColor: dark ? TColors.dark : TColors.white,
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row 1
              Row(
                children: [
                  const Icon(Iconsax.ship),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.orderStatusText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: TColors.primaryColor, fontWeightDelta: 1),
                        ),
                        Text(
                          order.formattedOrderDate,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Row 2
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order.id,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order.formattedDeliveryDate,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
class Order {
  final String id;
  final String orderStatusText;
  final String formattedOrderDate;
  final String formattedDeliveryDate;

  Order({
    required this.id,
    required this.orderStatusText,
    required this.formattedOrderDate,
    required this.formattedDeliveryDate,
  });
}
