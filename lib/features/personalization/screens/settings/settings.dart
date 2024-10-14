import 'package:emergencystore/features/personalization/screens/address/address.dart';
import 'package:emergencystore/features/personalization/screens/profile/profile.dart';
import 'package:emergencystore/features/store/screens/cart/cart.dart';
import 'package:emergencystore/features/store/screens/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Section with Header
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen(),),);
                  },
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                // Profile and Name
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jaskeerat Singh',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'singhjaskeerat753@gmail.com',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Menu Options
            _buildProfileOptionCard(
              icon: Iconsax.safe_home,
              title: 'My Addresses',
              subtitle: 'Set shopping delivery address',
              onTap: () => Get.to(() => const UserAddressScreen()),
            ),
            _buildProfileOptionCard(
              icon: Iconsax.shopping_cart,
              title: 'My Cart',
              subtitle: 'Add, remove products and move to checkout',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
            ),
            _buildProfileOptionCard(
              icon: Iconsax.bag_tick,
              title: 'My Orders',
              subtitle: 'In progress and completed orders',
              onTap: () {
                Get.to(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderScreen()));
                });
              },
            ),
            _buildProfileOptionCard(
              icon: Iconsax.bank,
              title: 'Bank Account',
              subtitle: 'Withdraw balance in registered bank account',
              onTap: () {},
            ),
            _buildProfileOptionCard(
              icon: Iconsax.discount_shape,
              title: 'My Coupons',
              subtitle: 'List of all the discounted coupons',
              onTap: () {},
            ),
            _buildProfileOptionCard(
              icon: Iconsax.notification,
              title: 'Notifications',
              subtitle: 'Set any kind of notification message',
              onTap: () {},
            ),
            _buildProfileOptionCard(
              icon: Iconsax.security_card,
              title: 'Account Privacy',
              subtitle: 'Manage data usage and connected accounts',
              onTap: () {},
            ),

            const SizedBox(height: 20),

            // App Settings Section
            const Text(
              'App Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            _buildProfileOptionCard(
              icon: Iconsax.document_upload,
              title: 'Load Data',
              subtitle: 'Upload data to your cloud Firebase',
              onTap: () {
                Get.to(() {});
              },
            ),
            _buildProfileOptionCard(
              icon: Iconsax.location,
              title: 'Geolocation',
              subtitle: 'Set recommendation based on location',
              onTap: () {},
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            _buildProfileOptionCard(
              icon: Iconsax.security_user,
              title: 'Safe Mode',
              subtitle: 'Search result is safe for all ages',
              onTap: () {},
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            _buildProfileOptionCard(
              icon: Iconsax.image,
              title: 'HD Image quality',
              subtitle: 'Set Image quality to be seen',
              onTap: () {},
              trailing: Switch(value: true, onChanged: (value) {}),
            ),

            const SizedBox(height: 20),

            // Logout Button
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Add your logout logic here
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper method to create profile option with shadow
  Widget _buildProfileOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) trailing else const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
