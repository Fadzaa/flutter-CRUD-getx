import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:technical_test1/app/modules/product_page/model/product_model.dart';
import 'package:technical_test1/app/routes/app_pages.dart';
import 'package:technical_test1/helpers/themes.dart';

import '../controllers/product_page_controller.dart';

class ProductPageView extends GetView<ProductPageController> {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get USer ID and fetch into userController
    final userId = controller.currentUser?.uid;
    controller.fetchFullName(userId.toString());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: StreamBuilder(
                stream: controller.streamProducts(),
                builder: (context, snapProducts) {
                  if (snapProducts.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  //Layout jika data kosong
                  if (snapProducts.data!.docs.isEmpty) {
                    return  Container(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 48,
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(64, 64, 64, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "U",
                                      style: iconStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Logout'),
                                          content: Text('Are you sure you want to logout?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Batalkan dialog
                                              },
                                              child: Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.auth.signOut();
                                                Get.offAllNamed(Routes.LOGIN_PAGE);
                                              },
                                              child: Text('Continue'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(iconLogout),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Welcome,",
                            style: welcomeText,
                          ),
                          SizedBox(height: 8,),
                          Obx(() {
                            if (controller.isGuest.value) {
                              return Text("Guest", style: nameText);
                            } else {
                              if (FirebaseAuth.instance.currentUser?.providerData.first.providerId == 'google.com') {
                                return Text(FirebaseAuth.instance.currentUser?.displayName ?? "Guest", style: nameText);
                              } else {
                                return Text(controller.fullName.value, style: nameText);
                              }
                            }
                          }),


                          SizedBox(height: 6,),
                          Text(
                            "Invest yourself with the greatest course you can found",
                            style: sloganHomePage,
                          ),
                          SizedBox(height: 16,),
                          Container(
                            width: 340,
                            height: 2,
                            color: Color(0xFF2A6B8F),
                          ),
                          SizedBox(height: 18,),
                          Text(
                            "All Course",
                            style: headerText,
                          ),
                          SizedBox(height: 50,),

                          Center(child: Text("No Course yet"))
                        ],
                      ),
                    );
                  }


                  controller.products.clear();

                  for (var element in snapProducts.data!.docs) {
                    controller.products.add(ProductModel.fromJson(element.data()));
                  }

                  return Container(
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),

                        Container(
                          height: 48,
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(64, 64, 64, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "U",
                                    style: iconStyle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Logout', style: dialogText(isTextDescription: false),),
                                    content: Text('Are you sure you want to logout?', style: dialogText(isTextDescription: true),),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Batalkan dialog
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.auth.signOut();
                                          Get.offAllNamed(Routes.LOGIN_PAGE);
                                          Get.snackbar("Success", "Logout Success");
                                        },
                                        child: Text('Continue'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10, top: 8),
                                child: Column(
                              children: [
                                SvgPicture.asset(iconLogout),
                                Text("Logout", style: TextStyle(color: primaryColor),)
                              ],
                            )),
                          ),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome,",
                          style: welcomeText,
                        ),
                        SizedBox(height: 8,),

                        //Obx untuk merubah nama user sesuai Authentication Method
                        Obx(() {
                          if (controller.isGuest.value) {
                            return Text("Guest", style: nameText);
                          } else {
                            if (FirebaseAuth.instance.currentUser?.providerData.first.providerId == 'google.com') {
                              return Text(FirebaseAuth.instance.currentUser?.displayName ?? "Guest", style: nameText);
                            } else {
                              return Text(controller.fullName.value, style: nameText);
                            }
                          }
                        }),

                        SizedBox(height: 6,),

                        Text(
                          "Invest yourself with the greatest course you can found",
                          style: sloganHomePage,
                        ),

                        SizedBox(height: 16,),
                        Container(
                          width: 340,
                          height: 2,
                          color: Color(0xFF2A6B8F),
                        ),

                        SizedBox(height: 18,),

                        Text(
                          "All Course",
                          style: headerText,
                        ),

                        SizedBox(height: 15,),

                        //Content Course
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return FutureBuilder<bool>(
                              future: controller.checkInternetConnectivity(),
                              builder: (context, snapshot) {
                                final product = controller.products[index];

                                if (snapshot.hasData && snapshot.data == true) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAILS_PRODUCT, arguments: product);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      height: 200,
                                      child: Card(
                                        color: Colors.transparent,
                                        elevation: 0.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(2),
                                                child: FadeInImage(
                                                  placeholder: AssetImage(
                                                    "assets/placeholder/dummy_600x400_ffffff_cccccc.png",
                                                  ),
                                                  image: NetworkImage(product.image),
                                                  fit: BoxFit.cover,
                                                  width: 165,
                                                  height: 110,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              product.title,
                                              style: titleProduct,
                                            ),
                                            Text(
                                              product.mentor,
                                              style: usernameProduct,
                                            ),
                                            SizedBox(height: 4),
                                            SvgPicture.asset("assets/Rate.svg"),
                                            SizedBox(height: 5),
                                            Text(
                                              "${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(product.price)}",
                                              style: priceProduct,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Card(
                                    child: Center(child: Text("")),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            //Add Course Button
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  if(controller.currentUser != null) {
                    Get.toNamed(Routes.ADD_PRODUCT);
                  }else{
                    Get.snackbar("Failed", "Need Authentication to add course");
                  }

                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(133, 40),
                  backgroundColor: primaryColor,
                  textStyle: courseButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add Course'),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );


  }




}
