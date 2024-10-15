import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/data/repositories/authentication_repository.dart';
import 'package:emergencystore/features/authentication/login/forgot/forgot_password.dart';
import 'package:emergencystore/features/authentication/login/sign_up/sign_up.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Controllers to capture email and password input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _fetchLocation() async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    final String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN';

    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${locationData.longitude},${locationData.latitude}.json?access_token=$mapboxAccessToken';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming you want the first result's place name
        return data['features'][0]['place_name'] ?? 'No Adress';
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      print('Error fetching location: $e');
      throw 'Error fetching location';
    }
  }

  void _showDialog(BuildContext context, String address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set the Location'),
          content: Text(address),
          actions: [
            TextButton(
              onPressed: () async {
                String userId = _auth.currentUser!.uid;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .update({
                  'location': FieldValue.arrayUnion(
                      [address]), // Add address to 'location' array
                });
                MaterialPageRoute(
                    builder: (context) => NavigationMenu()); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle sign-in using Firebase
  void _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user login state locally
      AuthenticationRepository.instance.saveUserLoggedInState();

      // If successful, navigate to the home page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully signed in!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NavigationMenu()), // Navigate to home page after sign in
      );
      // _showDialog(context, 'No Adress at present');
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                      text: 'In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Email Text Field
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE4E4E4),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        color: const Color(0xFFC62E2E).withOpacity(0.63),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password Text Field
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE4E4E4),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: const Color(0xFFC62E2E).withOpacity(0.63),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // Add functionality to toggle password visibility
                        },
                        child: const Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              // Continue Button
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _signIn(context);
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
                ),
              ),

              // Create an Account Prompt
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: const Text(
                    "Don't have an account? Create One",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Line Divider with OR
              const Row(
                children: [
                  Expanded(
                      child: Divider(color: Color(0xFFD4D4D4), thickness: 1.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR', style: TextStyle(color: Colors.black)),
                  ),
                  Expanded(
                      child: Divider(color: Color(0xFFD4D4D4), thickness: 1.0)),
                ],
              ),
              const SizedBox(height: 10),

              // Continue with Google Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality for continuing with Google
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
