import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_function.dart';

class TBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;

  const TBottomBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);

    return Material(
      color: isDarkMode ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.primaryColor,
        labelColor: isDarkMode ? TColors.white : TColors.primaryColor,
        unselectedLabelColor: TColors.darkGrey,
        indicatorWeight: 2.0, // Optional: Adjust to control the thickness of the indicator
        labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Optional: Add more styling if needed
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
