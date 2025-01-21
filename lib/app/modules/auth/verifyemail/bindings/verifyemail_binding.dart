import 'package:get/get.dart';

import '../controllers/verifyemail_controller.dart';

class VerifyemailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyemailController>(
      () => VerifyemailController(),
    );
  }
}
