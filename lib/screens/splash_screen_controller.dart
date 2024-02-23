import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(LoginScreen());
    });

    // if (FirebaseAuth.instance.currentUser == null) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     Get.off(LoginScreen());
    //   });
    // } else {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     Get.off(HomeScreen(msg: "",));
    //   });
    // }
  }
}
