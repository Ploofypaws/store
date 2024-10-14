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
