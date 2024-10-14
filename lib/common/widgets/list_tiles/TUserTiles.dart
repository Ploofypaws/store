import 'package:emergencystore/common/widgets/images/t_rounded_images.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Define static values or default values for demonstration purposes
    final String profilePicture = TImages.torchIcon;
    final String fullName = "John Doe";
    const String email = "johndoe@example.com";

    return ListTile(
      leading: TRoundedImage(
        image: profilePicture,
        isNetworkImage: false, // Assuming a static image is used
        radius: 80,
        applyImageRadius: true,
        imageUrl: '',
      ),
      title: Text(
        fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        email,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(()), // You can add your navigation logic here
        icon: const Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
