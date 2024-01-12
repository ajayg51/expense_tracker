import 'package:flutter/material.dart';

class CommonBackgroundGradient extends StatelessWidget {
  const CommonBackgroundGradient({super.key,this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal,
            Colors.amber,
            Color.fromARGB(255, 70, 67, 67),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: child,
    );
  }
}
