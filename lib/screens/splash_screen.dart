import 'dart:ffi';

import 'package:expense_tracker/screens/splash_screen_controller.dart';
import 'package:expense_tracker/utils/assets.dart';
import 'package:expense_tracker/utils/common_background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  final controller = Get.put(SplashScreenController());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    sizeAnimation =
        Tween<double>(begin: 100, end: 300).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CommonBackgroundGradient(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (_, __) => SvgPicture.asset(
                  Assets.rupeeSymbol,
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                ),
              ),
              Center(
                child: Text(
                  "Expense Tracker",
                  style: TextStyle(
                    fontSize: deviceWidth * 0.1,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
