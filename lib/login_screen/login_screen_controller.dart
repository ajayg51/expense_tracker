import 'package:expense_tracker/transaction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
  final isUserLoggedIn = false.obs;
  UserCredential? userCredential;

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      print("1");
      isUserLoggedIn.toggle();
      navigateToHomeScreen();
    } else {
      print("2");
      googleSignIn();
    }
  }

  void navigateToHomeScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.to(TransactionScreen());
    });
  }

  void googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential != null) {
        navigateToHomeScreen();
      }
      print("Here");
      print(userCredential);
    } catch (e) {
      print("error $e");
    }
  }
}
