import 'package:emergencystore/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emergencystore/features/authentication/login/sign_in/sign_in.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observables to handle password visibility and privacy policy acceptance
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // TextEditingControllers to capture form input
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  // GlobalKey for form validation
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Method to handle user registration
  Future<void> signup(BuildContext context) async {
    // Form validation
    if (!signupFormKey.currentState!.validate()) return;

    if (!privacyPolicy.value) {
      Get.snackbar('Privacy Policy', 'Please accept the terms and conditions.');
      return;
    }

    try {
      // Sign up with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Create user model with user info
      UserModel newUser = UserModel(
        id: userCredential.user?.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(newUser.id).set(newUser.toJson());

      // If successful, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully signed up!")),
      );

      // Navigate to the SignInPage
      Get.offAll(SignInPage());
    } on FirebaseAuthException catch (e) {
      // Show error message if sign-up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }
}
