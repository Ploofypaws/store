import 'package:emergencystore/features/authentication/screens/onboarding.dart';
import 'package:emergencystore/features/store/screens/home/home.dart';
import 'package:emergencystore/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        // Define your preferred colors here
        scaffoldBackgroundColor: Colors.white, // Set app background color
        primaryColor: Colors.black, // Primary color of the app

        // Floating Action Button theme customization
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black, // FAB color
        ),

        // Bottom Navigation Bar theme customization
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black, // Bottom navigation bar color
          selectedItemColor: Colors.white, // Selected item color
          unselectedItemColor: Colors.grey, // Unselected item color
        ),

        // Custom AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Set AppBar color to transparent
          elevation: 0, // Remove shadow
          iconTheme: IconThemeData(color: Colors.black), // Icon color
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), // Title text style
        ),

        // Other theme customizations
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.black, // Accent color for FAB, buttons, etc.
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:   const Scaffold(backgroundColor: Colors.black,body: Center(
        child: CircularProgressIndicator(color: Colors.white ,),
      ),),
    );
  }
}
