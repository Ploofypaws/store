// Replace the existing CartPage code with the following updated version
import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/features/personalization/controllers/address_controller.dart';
import 'package:emergencystore/features/personalization/models/address_model.dart';
import 'package:emergencystore/features/personalization/screens/address/add_new_address.dart';
import 'package:emergencystore/features/store/screens/checkout/checkout.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:emergencystore/razorpay/payment_razorpay.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final AddressController addressController = Get.put(AddressController());
  List<Address> addresses = [];
  String? selectedAddress;
  bool isCartEmpty = false; // Simulate empty cart status
  double totalCartPrice = 208.00; // Simulated total cart price

  @override
  void initState() {
    super.initState();
    _fetchAddresses(); // Fetch addresses when the page is initialized
  }

  Future<void> _fetchAddresses() async {
    addresses = await addressController.fetchAddresses();
    setState(() {});
  }

  void _checkout() {
    if (selectedAddress != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RazorPayScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an address.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isCartEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Whoops! Cart is empty',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationMenu())),
              child: const Text("Let's fill it"),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cart Items (replace with actual cart items UI)
              _buildCartItem('Gloves', 'High-quality safety gloves', 'Rs 198.00', TImages.glovesIcon),
              _buildCartItem('Sanitizer', 'Antibacterial hand sanitizer', 'Rs 98.00', TImages.medikitIcon),
              _buildCartItem('Face Mask', 'Disposable face masks', 'Rs 50.00', TImages.campIcon),

              const SizedBox(height: 20),
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Display the fetched addresses
              ...addresses.map((address) => _buildAddressOption(
                address.name,
                address.phoneNumber,
                '${address.street}, ${address.city}, ${address.stateOrDistrict}, ${address.country}',
              )),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Add Address logic
                },
                child:  Row(
                  children: [
                    Icon(Icons.add, color: Colors.blueAccent),
                    SizedBox(width: 5),
                    GestureDetector(onTap: () => Get.to(AddNewAddressScreen()),
                      child: Text(
                        'Add Address',
                        style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // Price Section
              const SizedBox(height: 20),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping', style: TextStyle(fontSize: 16)),
                  Text('Rs 0.00', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total (Including VAT)', style: TextStyle(fontSize: 16)),
                  Text(
                    'Rs $totalCartPrice',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Proceed to Checkout Button
              Center(
                child: ElevatedButton(
                  onPressed: _checkout,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(String title, String description, String price, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(image, width: 50, height: 50), // Replace with actual image
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(description),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressOption(String title, String phone, String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedAddress = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: selectedAddress == title ? Colors.blue[50] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedAddress == title ? Colors.blueAccent : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Radio(
                value: title,
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value as String?;
                  });
                },
                activeColor: Colors.blueAccent,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(phone),
                    Text(address, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
