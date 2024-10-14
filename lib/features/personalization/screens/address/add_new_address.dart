// ui/add_new_address_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/features/personalization/controllers/address_controller.dart';
import 'package:emergencystore/features/personalization/models/address_model.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of the AddressController
    final AddressController addressController = Get.put(AddressController());

    // Define controllers for each TextFormField
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController streetController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    // Create a GlobalKey to handle form validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: formKey,  // Assign the formKey here
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.defaultSpace),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: streetController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your street';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: postalCodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your postal code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Iconsax.house),
                          labelText: 'City',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Iconsax.map),
                          labelText: 'State/District',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state/district';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        // Fetch the current user's ID dynamically
                        String? userId = FirebaseAuth.instance.currentUser?.uid;

                        if (userId != null) {
                          Address address = Address(
                              // Dynamically assign the user ID
                            name: nameController.text.trim(),
                            phoneNumber: phoneNumberController.text.trim(),
                            street: streetController.text.trim(),
                            postalCode: postalCodeController.text.trim(),
                            city: cityController.text.trim(),
                            stateOrDistrict: stateController.text.trim(),
                            country: countryController.text.trim(),
                          );

                          // Call the controller to save the address
                          addressController.saveAddress(address).then((_) {
                            // Clear fields after saving
                            nameController.clear();
                            phoneNumberController.clear();
                            streetController.clear();
                            postalCodeController.clear();
                            cityController.clear();
                            stateController.clear();
                            countryController.clear();
                          });
                        } else {
                          Get.snackbar('Error', 'User not logged in');
                        }
                      }
                    },
                    child: const Text('Save Address'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
