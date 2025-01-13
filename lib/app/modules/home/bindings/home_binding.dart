import 'package:blogapp/app/modules/homePage/controllers/home_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );    
    Get.lazyPut<HomePageController>(
      () => HomePageController(),
    );
  }
}
