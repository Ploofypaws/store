
import 'package:emergencystore/features/store/screens/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/personalization/screens/settings/settings.dart';
import 'features/store/screens/shop/store.dart';
import 'features/store/screens/wishlist/favourite.dart';




class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return  Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          indicatorColor: Colors.black.withOpacity(0.5),
          height: 80,
          elevation: 0,
          selectedIndex:controller.selectedIndex.value,
          onDestinationSelected: (index)=>controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Fav'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{

  final Rx<int> selectedIndex = 0.obs;

  final screens = [ const HomeScreen(), const StoreScreen(), const FavoriteScreen(),const SettingsScreen()];
}