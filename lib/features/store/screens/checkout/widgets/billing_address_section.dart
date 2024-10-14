import 'package:emergencystore/common/widgets/texts/section_heading.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatefulWidget {
  const TBillingAddressSection({super.key});

  @override
  _TBillingAddressSectionState createState() => _TBillingAddressSectionState();
}

class _TBillingAddressSectionState extends State<TBillingAddressSection> {
  // Dummy data for selected address
  String selectedAddressName = 'John Doe';
  String selectedPhoneNumber = '+91 1234567890';
  String selectedAddress = '1234, Sector 12, City Name, Country';

  bool hasAddress = true; // Simulates if the address exists or not

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {
            _selectNewAddressPopup(context);
          },
        ),
        hasAddress
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selectedAddressName, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: TColors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(selectedPhoneNumber, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history, color: TColors.grey, size: 16),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: Text(
                    selectedAddress,
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        )
            : Text(
          'Select Address',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _selectNewAddressPopup(BuildContext context) {
    // Simulate address selection or prompt
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a New Address'),
          content: const Text('Address selection functionality is here.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Simulate address change
                  selectedAddressName = 'Jane Doe';
                  selectedPhoneNumber = '+91 9876543210';
                  selectedAddress = 'New Address, City, Country';
                  hasAddress = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Select Address'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
