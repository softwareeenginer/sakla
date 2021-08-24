import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

// ignore: must_be_immutable
class ProfileAppBar extends StatelessWidget {
  Widget? child;
  ProfileAppBar({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: DiagonalPathClipperOne(),
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

class DiagonalPathClipperOne extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height - 50.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
