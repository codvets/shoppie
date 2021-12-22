import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.topRight,
        radius: 0.5,
        colors: [
          Color(0xffFFA984),
          Color(0xffFF793F),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
