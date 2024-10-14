import 'package:emergencystore/common/widgets/appbar/appbar.dart';
import 'package:emergencystore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:emergencystore/features/personalization/screens/address/widgets/single_address.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => Get.to(()=> const AddNewAddressScreen()),
      child: const Icon(Iconsax.add,color: TColors.white,),),
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Address', ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
               TSingleAddress(selectedAddress: true),
               TSingleAddress(selectedAddress: false),
            ]
          ),
        ),
      ),
      );
  }
}
