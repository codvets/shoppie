import 'package:flutter/material.dart';

class LowerClippath extends CustomClipper<Path> {
  final double borderRadius = 0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);

    Offset firstControlPoint = Offset(size.width / 4, size.height);
    Offset firstPoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    Offset secondControlPoint = Offset(size.width / 4 * 3, size.height);
    Offset secondPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, size.height - 120);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
