import 'package:expense_tracker/screens/login_screen_controller.dart';
import 'package:expense_tracker/utils/common_background_gradient.dart';
import 'package:expense_tracker/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    final loginScreenStr =
        FirebaseAuth.instance.currentUser != null ? "Welcome" : "Logging In";
    return Scaffold(
      body: CommonBackgroundGradient(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(loginScreenStr),
              10.verticalSpace,
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
