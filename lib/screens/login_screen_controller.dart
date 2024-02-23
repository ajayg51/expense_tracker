import 'package:expense_tracker/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
  UserCredential? userCredential;

  final error = "Error".obs;
  final isLoading = true.obs;

  @override
  void onReady() async {
    super.onReady();
    await googleSignIn();
    // Get.off(HomeScreen(
    //   msg: error,
    // ));
    // if (FirebaseAuth.instance.currentUser != null) {
    //   Get.off(HomeScreen(msg: error,));
    // } else {
    //   await googleSignIn();
    //   Get.off(HomeScreen(msg: error,));
    // }
  }

  Future<void> googleSignIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    error.value = "here 0";

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    Future.delayed(const Duration(seconds: 2));
    error.value = "here 1";

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    Future.delayed(const Duration(seconds: 2));

    error.value = "here 2";

    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken,
    //   );

    //   try {
    //     userCredential =
    //         await FirebaseAuth.instance.signInWithCredential(credential);

    //     error.value = "here 1";

    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'account-exists-with-different-credential') {

    //       error.value = "here 2";

    //       // ...
    //     } else if (e.code == 'invalid-credential') {

    //       error.value = "here 3";
    //       // ...
    //     }
    //   } catch (e) {

    //     error.value = "here 4";

    //   }
    // } else {

    //   error.value = "here 5";

    // }

    isLoading.value = false;
    Future.delayed(const Duration(seconds: 2));
    
    error.value = "ending";
  }
}
