import 'package:emergencystore/features/store/screens/home/searched_items.dart';
import 'package:flutter/material.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    this.text = 'Search',
    this.icon = Icons.search,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData icon;
  final bool showBackground;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: showBackground
              ? (dark ? Colors.grey[800] : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          children: [
            SizedBox(width: width * 0.03),
            Icon(icon, color: Colors.grey),
            SizedBox(width: width * 0.03),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: text,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                onSubmitted: (value) {
                  // Navigate to ProductSearchScreen when user hits enter
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductSearchScreen(searchQuery: value),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
