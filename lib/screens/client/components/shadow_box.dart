import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ShadowBox extends StatelessWidget {
  final Widget? child;
  const ShadowBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.5, // Default: 0.5
      color: Colors.grey,
      offset: Offset(3, 3), // Default: Offset(2, 2)
      sigma: 7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
