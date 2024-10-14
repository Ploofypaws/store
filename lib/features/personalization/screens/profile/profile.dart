import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,

        title:  const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 52.0),
            child: Text(
              'Profile',style: TextStyle(color: Colors.black),

            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // Profile Image
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile_placeholder.png'), // Replace with your image
                  ),
                  const SizedBox(height: 8),
                  // Change Profile Picture Button
                  TextButton(
                    onPressed: () {
                      // Implement your change profile picture logic
                    },
                    child: const Text('Change Profile Picture'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Profile Information Section
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Name
            ListTile(
              title: const Text('Name'),
              subtitle: const Text('Jaskeerat Singh'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            // Username

            const SizedBox(height: 20),
            // Personal Information Section
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // User ID

            // Email
            ListTile(
              title: const Text('E-mail'),
              subtitle: const Text('jaskeerat.singh@example.com'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            // Phone Number
            ListTile(
              title: const Text('Phone Number'),
              subtitle: const Text('+1234567890'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            // Gender
            ListTile(
              title: const Text('Gender'),
              subtitle: const Text('Male'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            // Date of Birth
            ListTile(
              title: const Text('Date of Birth'),
              subtitle: const Text('01 Jan, 2000'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            const SizedBox(height: 20),
            // Close Account Button
            Center(
              child: TextButton(
                onPressed: () {
                  // Implement close account logic
                },
                child: const Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
