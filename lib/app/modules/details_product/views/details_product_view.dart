import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technical_test1/app/routes/app_pages.dart';
import 'package:technical_test1/helpers/themes.dart';

import '../../product_page/model/product_model.dart';
import '../controllers/details_product_controller.dart';

class DetailsProductView extends GetView<DetailsProductController> {
  DetailsProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    //Get Previous Text

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: 250,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.black.withOpacity(
                          0.1),
                    ),
                    //Icon
                    Positioned(
                      left: 21,
                      top: 38,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            iconArrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Details Content
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx( () => controller.isTextFieldVisible.value
                          ? CustomTextField(
                        hintText: "Enter new course name",
                        text: "Course Name",
                        controller: controller.cName,
                        textInputType: TextInputType.name,)
                          : Text(
                        product.title,
                        style: detailsCourseName,
                      ),),
                      SizedBox(height: 2),

                      Obx( () => controller.isTextFieldVisible.value
                          ? Text("")
                          : Text(product.mentor, style: detailsMentorText,),
                      ),

                      SizedBox(height: 8),


                      Obx( () => controller.isTextFieldVisible.value
                          ? CustomTextField(hintText: "Enter new course price", text: "Course Price", controller: controller.cPrice, textInputType: TextInputType.number,)
                          : Text(
                        "${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(product.price)}",
                        style: detailsPriceText,
                      ),),
                      //Rating Image

                      SizedBox(height: 20),

                      Obx( () => controller.isTextFieldVisible.value
                          ? Text("")
                          : Text(
                        "About Course",
                        style: headerText,
                      ),),



                      Obx(
                            () => controller.isTextFieldVisible.value
                            ? CustomTextField(hintText: "Enter new course description", text: "Course Description", controller: controller.cDescription,textInputType: TextInputType.multiline,)
                            : Container(
                          margin: EdgeInsets.only(right: 22),
                          child: Text(
                            product.description,
                            style: detailsDescriptionText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        child: Row(
          children: [
            Container(
              height: 70,
              width: width * 0.5,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1.0,
                  ),
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Menampilkan dialog konfirmasi
                  if(controller.currentUser != null) {
                    Get.dialog(
                      AlertDialog(
                        content: Column(

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Delete Course',
                              textAlign: TextAlign.center,
                              style: dialogText(isTextDescription: false),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Are you sure to delete this product?',
                              textAlign: TextAlign.center,
                              style: dialogText(isTextDescription: true),
                            ),
                          ],
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextButton(
                                    onPressed: () {
                                      // Menutup dialog
                                      Get.back();
                                    },
                                    child: Text('No', style: TextStyle(color: primaryColor),),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(

                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                                    onPressed: () async {
                                      // Menutup dialog
                                      Get.back();
                                      // Melakukan proses delete product
                                      Map<String, dynamic> result = await controller.deleteProduct(product.id);
                                      Get.offAllNamed(Routes.PRODUCT_PAGE);
                                      Get.snackbar(
                                        result["error"] == true ? "Error" : "Success",
                                        result["message"],
                                      );


                                    },
                                    child: Text('Yes'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    );


                  }else{
                    Get.snackbar("Failed", "Need Authentication to delete course");
                  }

                },
                icon: SvgPicture.asset(
                  iconTrash,
                  color: warningColor,
                ),
                label: Text(
                  'Delete Course',
                  style: detailButtonsText(isDelete: true),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              ),

            ),
            SizedBox(width: 0), // No space between buttons
            Container(
              height: 70,
              width: width * 0.5,
              color: Color(0xFF2A6B8F),
              child: Obx(
                    () => ElevatedButton(
                  onPressed: () async {
                    if(controller.currentUser != null) {
                      controller.toggleTextFieldVisibility();
                      if(controller.isTextFieldVisible.value == false){
                        Map<String, dynamic> result = await controller.updateProduct(
                            {
                              "id" : product.id,
                              "title" : controller.cName.text,
                              "price" : int.parse(controller.cPrice.text),
                              "description" : controller.cDescription.text,

                            }
                        );

                        Get.back();
                        Get.snackbar(
                          result["error"] == true ? "Error" : "Success",
                          result["message"],
                        );


                      }
                    }else{
                      Get.snackbar("Failed", "Need Authentication to update course");
                    }



                  },
                  child: Text(
                    controller.isTextFieldVisible.value ? 'Save' : 'Edit',
                    style: detailButtonsText(isDelete: false),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.text,
    required this.textInputType,
    required this.controller,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338,
      height: 74,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: headerText,),
          SizedBox(height: 10,),
          TextField(
            style: editTextStyle,
            keyboardType: textInputType,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: hintText,
              hintStyle: hintTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: lineColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: lineColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: lineColor),
              ),


            ),
          ),
        ],
      ),
    );
  }
}
