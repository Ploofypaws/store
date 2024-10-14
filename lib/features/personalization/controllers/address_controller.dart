// controllers/address_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/features/personalization/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAddress(Address address) async {
    try {
      await _firestore.collection('addresses').add(address.toMap());
      Get.snackbar('Success', 'Address saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save address: $e');
    }
  }

  // New function to fetch addresses
  Future<List<Address>> fetchAddresses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('addresses').get();
      return snapshot.docs.map((doc) => Address.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch addresses: $e');
      return [];
    }
  }
}
