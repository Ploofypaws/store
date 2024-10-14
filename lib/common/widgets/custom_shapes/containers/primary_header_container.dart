import 'package:emergencystore/common/widgets/custom_shapes/curved_edges/custom_curved_edges.dart';
import 'package:emergencystore/utils/constants/colors.dart';

import 'package:flutter/material.dart';
class tPrimaryHeaderContainer extends StatelessWidget {
  const tPrimaryHeaderContainer({
    super.key, required child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: Container(
        color: TColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 350,
            )
          ],
        ),
      ),
    );
  }
}