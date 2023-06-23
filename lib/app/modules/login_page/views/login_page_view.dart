import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:technical_test1/app/routes/app_pages.dart';
import 'package:technical_test1/helpers/themes.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(right: 0, top: 0, child: SvgPicture.asset(topDecoration)),

            Container(
              width: double.infinity,
              height: size.height * 1,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 33),
                    child: SvgPicture.asset(smallLogo),
                  ),

                  const SizedBox(height: 53),

                  Text("Welcome Back!", style: sectionTitle,),

                  const SizedBox(height: 20),

                  Text("Lets Continue with Sign In!", style: sectionSlogan),

                  const SizedBox(height: 53),

                  Text("Email", style: primaryTextStyle,),

                  const SizedBox(height: 20,),

                  CustomTextField(hintText: "Enter your email here", prefixIcon: iconEmail, controller: controller.emailController),

                  const SizedBox(height: 25,),

                  Text("Password", style: primaryTextStyle,),

                  const SizedBox(height: 20,),

                  CustomTextField(hintText: "Enter your password here", prefixIcon: iconPassword, controller: controller.passwordController, obscureText: true),


                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Get.offAndToNamed(Routes.PRODUCT_PAGE),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(top: 30, right: 20, bottom: 23),
                        ),
                      ),
                      child: Text(
                        "Continue as Guest",
                        style: authMethodText(isTextButton: true),
                      ),
                    ),
                  ),

                  const LoginButton(isGoogle: false, text: "Sign In"),

                  const SizedBox(height: 16),

                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 20, bottom: 16),
                      child: Text("or", style: hintTextStyle)
                  ),


                  const LoginButton(isGoogle: true, text: "Sign In with Google"),

                  const SizedBox(height: 35),

                  SignInText(onPressed: () => Get.offAndToNamed(Routes.REGISTER_PAGE)),

                  const SizedBox(height: 20,),


                ],
              ),
            ),
          ],
        ),
      ),
    );

  }


}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String prefixIcon;
  final TextEditingController controller;

  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338,
      height: 45,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: lineColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: lineColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: lineColor),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 13),
            child: SvgPicture.asset(prefixIcon),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final bool isGoogle;
  final String text;

  const LoginButton({
    Key? key,
    required this.isGoogle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginPageController get = Get.put(LoginPageController());
    return Container(
      width: 338,
      height: isGoogle ? 55 : 50,

      child: ElevatedButton( // Replace Container with ElevatedButton
        onPressed: isGoogle? (){
          get.signInWithGoogle();
        } : (){get.signInWithEmailAndPassword();},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isGoogle ? Colors.white : const Color(0xFF2A6B8F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: isGoogle ? BorderSide(color: lineColor, width: 1) : BorderSide.none,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoogle) ...[
              SvgPicture.asset(googleIcon),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: isGoogle ? buttonText(isGoogle: true) : buttonText(isGoogle: false),
            ),
          ],
        ),
      ),
    );
  }
}


class SignInText extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInText({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't have an account? ",
          style: authMethodText(isTextButton: false)
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Sign up",
            style: authMethodText(isTextButton: true)
          ),
        ),
      ],
    );
  }
}


