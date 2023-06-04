import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:technical_test1/app/routes/app_pages.dart';

class RegisterPageController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  RxBool isLoading = false.obs;

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

  Future<void> registerWithEmailPassword() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if(validateFields()) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'fullName': fullNameController.text,
        });
        // Handle the successful registration
        // e.g., navigate to the home page
        Get.snackbar('Success', 'Register Success');
        Get.offAllNamed(Routes.LOGIN_PAGE);
      } catch (e) {
        // Handle registration errors
        // e.g., display an error message to the user
        print('Registration error: $e');
        // You can show an error message using Get.snackbar or any other method
        Get.snackbar('Error', 'Failed to register. Please try again.');
      } finally {
        isLoading.value = false;
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.onClose();
  }
}
