import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/details_product/bindings/details_product_binding.dart';
import '../modules/details_product/views/details_product_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/product_page/bindings/product_page_binding.dart';
import '../modules/product_page/views/product_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.PRODUCT_PAGE,
        page: () => const ProductPageView(),
        binding: ProductPageBinding(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 1500)),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
        name: _Paths.LOGIN_PAGE,
        page: () => const LoginPageView(),
        binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
        name: _Paths.ADD_PRODUCT,
        page: () => const AddProductView(),
        binding: AddProductBinding()
    ),
    GetPage(
      name: _Paths.DETAILS_PRODUCT,
      page: () => DetailsProductView(),
      binding: DetailsProductBinding(),
    ),
  ];
}
