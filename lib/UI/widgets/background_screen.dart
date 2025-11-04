import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/asset_paths.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPaths.background,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),


      ],
    );
  }
}
