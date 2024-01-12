import 'package:expense_tracker/splash_and_login_screens/login_screen.dart';
import 'package:expense_tracker/transaction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    if (FirebaseAuth.instance.currentUser == null) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(LoginScreen());
      });
    }else{
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(TransactionScreen());
      });
    }
  }
}
