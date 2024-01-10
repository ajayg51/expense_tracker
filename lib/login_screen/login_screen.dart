import 'package:expense_tracker/login_screen/login_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginScreenController());
  
  @override
  Widget build(BuildContext context) {
    final loginScreenStr = FirebaseAuth.instance.currentUser != null ? "Welcome" : "Logging In";
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(loginScreenStr),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
