import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:technical_test1/app/routes/app_pages.dart';

import '../controllers/add_product_controller.dart';
import 'package:technical_test1/helpers/themes.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userId =  controller.currentUser?.uid;
    controller.fetchFullName(userId.toString());

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.offAllNamed(Routes.PRODUCT_PAGE),
                      child: SizedBox(

                          child: SvgPicture.asset(iconArrow, color: Colors.black,))),
                  SizedBox(width: 10),
                  Text('Add Product', style: appBarText),
                ],
              ),
              SizedBox(height: 30),
              Text("Course Name", style: primaryTextStyle),
              SizedBox(height: 15),
              CustomTextField(
                hint: "Enter Course Name",
                textEditingController: controller.cName,
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 29),
              Text("Image Course", style: primaryTextStyle),
              SizedBox(height: 20),
              //Image Show
              Container(
                margin: const EdgeInsets.only(right: 25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xFFB5B5B5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Obx(() {
                      final imagePath = controller.imagePath.value;
                      if (imagePath.isNotEmpty) {
                        return Image.file(
                          File(imagePath),
                          width: 200,
                          fit: BoxFit.fill,
                        );
                      } else {
                        // Tampilkan UI tambahan jika belum ada gambar terpilih
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/add-product.svg',
                              width: 105,
                              height: 105,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Upload Here',
                              style: TextStyle(fontSize: 16, color: primaryColor),
                            ),
                          ],
                        );
                      }
                    }),


                  ),
                ),
              ),

              SizedBox(height: 30),
              Text("Course Price", style: primaryTextStyle),
              SizedBox(height: 15),
              CustomTextField(
                hint: "Enter Course Price",
                textEditingController: controller.cPrice,
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 40),

              Text("Course Description", style: primaryTextStyle),
              SizedBox(height: 15),
              CustomTextField(
                hint: "Enter Course Desription",
                textEditingController: controller.cDescription,
                textInputType: TextInputType.multiline,
              ),

              SizedBox(height: 35),

              Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(right: 25),
                child: ElevatedButton(
                  onPressed: () async {
                    print(controller.cName.text);

                    String? imageUrl = await controller.uploadImageToFirebaseStorage(controller.imagePath.value);
                    if (controller.cName.text.isNotEmpty && controller.cPrice.text.isNotEmpty && controller.cDescription.text.isNotEmpty) {
                      Map<String, dynamic> result =
                      await controller.addProduct({
                        "title": controller.cName.text,
                        "price": int.parse(controller.cPrice.text),
                        "description": controller.cDescription.text,
                        "mentor": controller.isGuest.value ? "Guest"
                            : (FirebaseAuth.instance.currentUser?.providerData.first.providerId == 'google.com'
                            ? (FirebaseAuth.instance.currentUser?.displayName ?? "Guest")
                            : controller.fullName.value),
                      },imageUrl!);


                      Get.back();
                      Get.snackbar(
                          result["error"] == true ? "Error" : "Success",
                          result["message"]);
                    } else {
                      Get.snackbar("Error", "Please fill all data.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Publish",
                    style: buttonText(isGoogle: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType textInputType;

  const CustomTextField(
      {required this.hint, required this.textEditingController, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: lineColor, width: 1.0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(

          children: [
            Expanded(
              child: TextField(
                style: editTextStyle,
                keyboardType: textInputType,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintStyle: hintTextStyle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
