import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/features/authentication/login/sign_in/sign_in.dart';
import 'package:emergencystore/features/authentication/screens/onboarding.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final deviceStorage = GetStorage();

  @override
  void onReady() async {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    // Check if user is logged in
    bool? isLoggedIn = deviceStorage.read('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Get.offAll(() => NavigationMenu());
    } else {
      bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;
      deviceStorage.writeIfNull('isFirstTime', true);
      isFirstTime
          ? Get.offAll(() => OnboardingScreen())
          : Get.offAll(() => SignInPage());
    }
  }

  Future<void> saveUserLoggedInState() async {
    deviceStorage.write('isLoggedIn', true);
  }

  Future<bool> hasLocation() async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get the current user's ID
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Check if the document exists
    if (userDoc.exists) {
      // Cast the document data to a Map
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

      // Check if 'location' field exists and if it's a list that is not empty
      if (data != null && data.containsKey('location')) {
        var location = data['location'];
        return location is List &&
            location.isNotEmpty; // Return true only if it's a non-empty list
      }
    }
    return false; // User document does not exist or location field is empty
  }

  Future<void> clearUserLoggedInState() async {
    deviceStorage.write('isLoggedIn', false);
    deviceStorage.write('isFirstTime', true);
  }

  // Register method (kept for reference)
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<void> logoutEmailandPassword() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }
}
