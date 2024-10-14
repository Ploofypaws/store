import 'package:emergencystore/features/authentication/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using Get.put to inject OnboardingController into the widget tree
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // PageView to display onboarding images
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.images.length,
            onPageChanged: (int page) {
              controller.updatePageIndicator(page);
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Text at the Bottom Left
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.titles[controller.currentPage.value],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Come along with ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextSpan(
                        text: "Us",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Book a ride when you need it,\nyour seat is guaranteed',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            )),
          ),

          // Dots at the Bottom Left
          Positioned(
            bottom: 20,
            left: 20,
            child: Obx(() => Row(
              children: List.generate(controller.images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: controller.currentPage.value == index ? 24.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? const Color(0xFFFF0000) // Red for the selected dot
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                );
              }),
            )),
          ),

          // Floating action button for "Next" or "Get Started" on the right bottom
          Positioned(
            bottom: 20,
            right: 20,
            child: Obx(() => controller.currentPage.value != controller.images.length - 1
                ? FloatingActionButton(
              onPressed: controller.nextPage, // Call controller to go to next page
              child: const Icon(Icons.arrow_forward),
            )
                : FloatingActionButton.extended(
              onPressed: controller.nextPage, // On the last page, call nextPage to transition to sign-in
              label: const Text('Get Started'),
            )),
          ),
        ],
      ),
    );
  }
}
