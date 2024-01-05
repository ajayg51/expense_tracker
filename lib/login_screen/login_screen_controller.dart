import 'package:expense_tracker/transaction_screen.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.to(TransactionScreen());
    });
  }

  
}
