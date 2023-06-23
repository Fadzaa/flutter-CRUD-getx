import 'package:get/get.dart';
import 'package:technical_test1/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {


  Future splash() async {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(
        Routes.LOGIN_PAGE,
      );
    });
  }

  @override
  void onInit() {

    super.onInit();
    splash();
  }

}
