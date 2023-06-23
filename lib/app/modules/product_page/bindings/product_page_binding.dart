import 'package:get/get.dart';

import '../controllers/product_page_controller.dart';

class ProductPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductPageController>(
      () => ProductPageController(),
    );
  }
}
