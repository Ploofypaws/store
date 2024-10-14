import 'package:emergencystore/features/authentication/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.signupFormKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign ',
                        style: TextStyle(color: Color(0xFFFF0E0E)),
                      ),
                      TextSpan(
                        text: 'Up',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // First Name
                TextFormField(
                  controller: controller.firstName,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    filled: true,
                    fillColor: const Color(0xFFE4E4E4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Last Name
                TextFormField(
                  controller: controller.lastName,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    filled: true,
                    fillColor: const Color(0xFFE4E4E4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Email
                TextFormField(
                  controller: controller.email,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    filled: true,
                    fillColor: const Color(0xFFE4E4E4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Password
                Obx(() => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: const Color(0xFFE4E4E4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(controller.hidePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 15),

                // Privacy Policy Checkbox
                Obx(() => CheckboxListTile(
                  title: const Text("I accept the terms and conditions"),
                  value: controller.privacyPolicy.value,
                  onChanged: (value) {
                    controller.privacyPolicy.value = value!;
                  },
                )),
                const SizedBox(height: 20),

                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    controller.signup(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0E0E),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
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
