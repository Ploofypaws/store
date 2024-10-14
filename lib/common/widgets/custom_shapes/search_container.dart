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
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: showBackground ? (dark ? Colors.grey[800] : Colors.grey[100]) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 8.0),
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
                      builder: (context) => ProductSearchScreen(searchQuery: value),
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
