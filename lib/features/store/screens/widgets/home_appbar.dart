import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:emergencystore/features/store/screens/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class THomeAppBar extends StatefulWidget {
  const THomeAppBar({super.key});

  @override
  _THomeAppBarState createState() => _THomeAppBarState();
}

class _THomeAppBarState extends State<THomeAppBar> {
  String? userName;
  bool isLoading = true; // To track loading state
  String errorMessage = ''; // To hold error messages

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name']; // Assuming 'name' is the field where you store the user's name
            isLoading = false; // Update loading state
          });
        } else {
          setState(() {
            userName = 'Guest';
            isLoading = false; // Update loading state
          });
        }
      } else {
        setState(() {
          userName = 'Guest';
          isLoading = false; // Update loading state
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load user name'; // Set error message
        isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppBarTitle,
            style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
          // Display loading indicator or user name
          isLoading
              ? CircularProgressIndicator() // Loading indicator
              : Text(
            userName ?? 'Guest',
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
          ),
          // Display error message if any
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red), // Error message styling
            ),
        ],
      ),
      actions: [
        TCartCounterIcons(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
          },
        ),
      ],
    );
  }
}
