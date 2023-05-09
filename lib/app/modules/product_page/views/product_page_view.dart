
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:technical_test1/app/modules/product_page/model/product_model.dart';

import '../controllers/product_page_controller.dart';

class ProductPageView extends GetView<ProductPageController> {

  const ProductPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text("Technical Test 2"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: controller.streamProducts(),
            builder: (context, snapProducts) {

              if (snapProducts.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapProducts.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No products"),
                );
              }

              for (var element in snapProducts.data!.docs) {
                controller.products.add(ProductModel.fromJson(element.data()));
              }

          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return FutureBuilder<bool>(
                future: controller.checkInternetConnectivity(),
                builder: (context, snapshot) {
                  final product = controller.products[index];

                  if (snapshot.hasData && snapshot.data == true) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInImage(
                              placeholder: AssetImage("assets/placeholder/dummy_600x400_ffffff_cccccc.png"),
                              image: NetworkImage(product.image),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 110,
                            ),
                            Text(product.title,style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                            Text('ID: ${product.id}',style: TextStyle(fontSize: 7),),
                            Text('Price: ${product.price}',style : TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/placeholder/dummy_600x400_ffffff_cccccc.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 110,
                            ),
                            Text(product.title,style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
                            Text('ID: ${product.id}',style: TextStyle(fontSize: 7),),
                            Text('Price: ${product.price}',style : TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        })
    );
  }
}
