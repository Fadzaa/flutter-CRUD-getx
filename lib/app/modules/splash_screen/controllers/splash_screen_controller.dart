import 'package:get/get.dart';
import 'package:technical_test1/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  // String name = "Fattah Anggit Al Dzakwan";

  Future splash() async {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(Routes.PRODUCT_PAGE);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    splash();
  }

}
