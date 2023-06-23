import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:technical_test1/app/routes/app_pages.dart';
import 'package:technical_test1/helpers/themes.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({Key? key}) : super(key: key);
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

                  Text("Hello There!", style: sectionTitle,),

                  const SizedBox(height: 20),

                  Text("Lets Begin with Sign Up!", style: sectionSlogan),

                  const SizedBox(height: 30),

                  Text("Full Name", style: primaryTextStyle,),

                  const SizedBox(height: 20,),

                  CustomTextField(hintText: "Enter your full name here", prefixIcon: iconEmail, controller: controller.fullNameController),

                  const SizedBox(height: 25,),

                  Text("Email", style: primaryTextStyle,),

                  const SizedBox(height: 20,),

                  CustomTextField(hintText: "Enter your email here", prefixIcon: iconEmail, controller: controller.emailController),

                  const SizedBox(height: 25,),

                  Text("Password", style: primaryTextStyle,),

                  const SizedBox(height: 20,),

                  CustomTextField(hintText: "Enter your password here", prefixIcon: iconPassword, controller: controller.passwordController, obscureText: true),

                  const SizedBox(height: 35,),

                  const RegisterButton(isGoogle: false, text: "Sign Up"),

                  const SizedBox(height: 16),

                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 20, bottom: 16),
                      child: Text("or", style: hintTextStyle)
                  ),


                  const RegisterButton(isGoogle: true, text: "Sign In with Google"),


                  const SizedBox(height: 15),

                  SignUpText(onPressed: () => Get.offAndToNamed(Routes.LOGIN_PAGE)),


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


class RegisterButton extends StatelessWidget {
  final bool isGoogle;
  final String text;

  const RegisterButton({
    Key? key,
    required this.isGoogle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterPageController get = Get.put(RegisterPageController());
    return Container(
      width: 338,
      height: isGoogle ? 55 : 50,
      child: ElevatedButton(// Replace Container with ElevatedButton
        onPressed: isGoogle? (){
          get.signInWithGoogle();
        } : (){
          get.registerWithEmailPassword();
          },
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



class SignUpText extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpText({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Already have an account? ",
            style: authMethodText(isTextButton: false)
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
              "Sign In",
              style: authMethodText(isTextButton: true)
          ),
        ),
      ],
    );
  }
}
