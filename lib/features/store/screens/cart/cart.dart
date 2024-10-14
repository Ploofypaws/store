// Replace the existing CartPage code with the following updated version
import 'package:emergencystore/common/styles/shadows.dart';
import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/features/personalization/controllers/address_controller.dart';
import 'package:emergencystore/features/personalization/models/address_model.dart';
import 'package:emergencystore/features/personalization/screens/address/add_new_address.dart';
import 'package:emergencystore/features/store/screens/cart/controllers/cart_controller.dart';
import 'package:emergencystore/features/store/screens/checkout/checkout.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:emergencystore/razorpay/payment_razorpay.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:emergencystore/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  double totalCartPricee = 208.00; // Simulated total cart price
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch addresses when the page is initialized
  }

  Future<void> _fetchData() async {
    final CartController cartController = Get.put(CartController());
    cartController.fetchCartItems();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final CartController cartController = Get.put(CartController());
    double totalCartAmount = cartController.cartItems
        .fold(0, (sum, item) => sum + double.parse(item.price));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: cartController.cartItems.isEmpty
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
                    SizedBox(
                      height: height * 0.425,
                      child: ListView.builder(
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cartItems[index];
                            return _buildCartItem(item.title, item.description,
                                item.price, item.image, height, width);
                          }),
                    ),

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
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.blueAccent),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => Get.to(AddNewAddressScreen()),
                            child: Text(
                              'Add Address',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 16),
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
                        const Text('Total (Including VAT)',
                            style: TextStyle(fontSize: 16)),
                        Text(
                          'Rs $totalCartAmount',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
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

  Widget _buildCartItem(String title, String description, String price,
      String image, double height, double width) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.005),
      child: SizedBox(
        height: height * 0.13,
        child: Card(
          elevation: 8,
          shadowColor: Colors.grey.withOpacity(0.4),
          child: Row(
            children: [
              ClipRect(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [TShadowStyle.horizontalProductShadow],
                    borderRadius:
                        BorderRadius.circular(TSizes.productImageRadius),
                    color: dark ? TColors.darkerGrey : TColors.white,
                  ),
                  child: Image.network(image,
                      width: width * 0.24, height: height * 0.12),
                ),
              ), // Replace with actual image
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: width * 0.4, child: Text(description)),
                    Row(
                      children: [
                        Text('Rs $price',
                            style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: TSizes.spaceBtwSections * 3.3),
                        Container(
                          width: width * 0.16,
                          height: height * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '-',
                                style: TextStyle(fontSize: width * 0.04),
                              ),
                              Text(
                                '$quantity',
                                style: TextStyle(fontSize: width * 0.04),
                              ),
                              Text(
                                '+',
                                style: TextStyle(fontSize: width * 0.04),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            color:
                selectedAddress == title ? Colors.blue[50] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedAddress == title
                  ? Colors.blueAccent
                  : Colors.transparent,
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
                    selectedAddress = value;
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
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
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
