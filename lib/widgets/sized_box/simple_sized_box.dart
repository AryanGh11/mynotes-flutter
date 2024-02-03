import 'package:flutter/material.dart';

class SimpleSizedBox extends StatelessWidget {
  const SimpleSizedBox({
    super.key,
    required this.height,
    this.child,
  });
  final int height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.toDouble(),
      child: child,
    );
  }
}
