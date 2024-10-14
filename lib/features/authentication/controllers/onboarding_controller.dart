import 'package:emergencystore/features/authentication/login/sign_in/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final PageController pageController = PageController();
  Rx<int> currentPage = 0.obs;

  // List of images and titles
  final List<String> images = [
    'assets/images/onboarding/onboarding1.png',
    'assets/images/onboarding/onboarding2.png',
    'assets/images/onboarding/onboarding3.png',
  ];

  final List<String> titles = [
    'Find your ride instantly',
    'Track your journey easily',
    'Enjoy a seamless travel experience',
  ];

  void updatePageIndicator(int index) {
    currentPage.value = index;
  }

  void dotNavigationClick(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (currentPage.value == 2) {
      // When user is on the last page (index 2), transition to sign-in
      final storage = GetStorage();

      if (kDebugMode) {
        print('----------------------User on last page-----------------------------------');
        print('isFirstTime: ${storage.read('isFirstTime')}');
      }

      // Mark that the user has completed onboarding
      storage.write('isFirstTime', false);

      // Redirect to the sign-in page
      Get.offAll(SignInPage());
    } else {
      // Otherwise, move to the next page
      int nextPage = currentPage.value + 1;
      pageController.jumpToPage(nextPage);
    }
  }

  void skipPage() {
    // Skip to the last page (index 2)
    currentPage.value = 2;
    pageController.jumpToPage(2);
  }
}
