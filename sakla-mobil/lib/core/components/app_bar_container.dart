import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

// ignore: must_be_immutable
class AppBarContainer extends StatelessWidget {
  Widget? child;
  AppBarContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: context.height / 5.4,
          width: context.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff252880), Color(0xff252850)])),
          child: child,
        ),
      ),
    );
  }
}

class OvalBottomBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
