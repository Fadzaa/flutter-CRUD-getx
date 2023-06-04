import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:technical_test1/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validateFields() {
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email format');
      return false;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Please enter at least 6 characters for the password');
      return false;
    }

    return true;
  }

  Future<void> signInWithEmailAndPassword() async {
    if (validateFields()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        // Handle the successful sign-in
        // e.g., navigate to the home page
        Get.snackbar('Success', 'Login Success');
        Get.offAllNamed(Routes.PRODUCT_PAGE);
      } catch (e) {

        Get.snackbar('Error', 'Failed to sign in. Invalid email or pasword');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Handle the successful sign-in
      // e.g., navigate to the home page
      Get.snackbar('Success', 'Google Sign-In Success');
      Get.offAllNamed(Routes.PRODUCT_PAGE);
    } catch (e) {
      // Handle sign-in errors
      // e.g., display an error message to the user
      print('Google Sign-In error: $e');
      // You can show an error message using Get.snackbar or any other method
      Get.snackbar('Error', 'Failed to sign in with Google. Please try again. $e');
    }
  }
}
