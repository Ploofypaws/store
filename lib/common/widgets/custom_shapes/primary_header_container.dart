import 'package:emergencystore/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

// Custom Painter for Dot Pattern
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.2);
    double spacing = 20;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Main Header Container
class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: TColors.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * 0.03),
              bottomRight: Radius.circular(width * 0.03))),
      child: SizedBox(
        height: height * 0.35,
        child: Stack(
          children: [
            // CustomPaint to draw the dot pattern
            CustomPaint(
              painter: DotPatternPainter(),
              child: Container(),
            ),
            // Positioned circular containers for design
            // Positioned(
            //   top: -150,
            //   right: -250,
            //   child: TCircularContainer(
            //     backgroundColor: TColors.black.withOpacity(0.1),
            //   ),
            // ),
            // Positioned(
            //   top: 100,
            //   right: -300,
            //   child: TCircularContainer(
            //     backgroundColor: TColors.black.withOpacity(0.1),
            //   ),
            // ),
            // Positioned Images at the bottom

            // Child widget that you pass from outside
            child,
          ],
        ),
      ),
    );
  }
}
