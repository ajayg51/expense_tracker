import 'package:expense_tracker/splash_and_login_screens/login_screen.dart';
import 'package:expense_tracker/splash_and_login_screens/splash_screen.dart';
import 'package:expense_tracker/main_controller.dart';
import 'package:expense_tracker/transaction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
