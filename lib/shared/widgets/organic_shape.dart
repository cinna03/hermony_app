import 'package:flutter/material.dart';

class OrganicShape extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final List<BoxShadow>? shadow;
  final EdgeInsets? padding;

  const OrganicShape({
    Key? key,
    required this.child,
    required this.color,
    this.borderRadius = 24.0,
    this.shadow,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius * 0.8),
          topRight: Radius.circular(borderRadius * 1.2),
          bottomLeft: Radius.circular(borderRadius * 1.2),
          bottomRight: Radius.circular(borderRadius * 0.8),
        ),
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}

class OrganicShapeClipper extends CustomClipper<Path> {
  final double borderRadius;

  OrganicShapeClipper({this.borderRadius = 24.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = Radius.circular(borderRadius);

    path.moveTo(0, borderRadius * 0.8);
    
    // Top left curve
    path.quadraticBezierTo(
      0,
      0,
      borderRadius * 0.8,
      0,
    );

    // Top right curve
    path.lineTo(size.width - borderRadius * 1.2, 0);
    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      borderRadius * 1.2,
    );

    // Bottom right curve
    path.lineTo(size.width, size.height - borderRadius * 0.8);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - borderRadius * 0.8,
      size.height,
    );

    // Bottom left curve
    path.lineTo(borderRadius * 1.2, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - borderRadius * 1.2,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
