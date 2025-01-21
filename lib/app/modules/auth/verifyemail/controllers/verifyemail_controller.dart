
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/config/api_config.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../data/services/api_service.dart';
import '../../../../routes/app_pages.dart';

class VerifyemailController extends GetxController {
  //todo: Implement VerifyemailController
  final ApiService _apiService = Get.find<ApiService>();
  final Rx<bool> isSubmitting = Rx<bool>(false);
  // formulare controllers
  final GlobalKey<FormState> verifyPinFormKey = GlobalKey<FormState>();
  final TextEditingController pincontroller = TextEditingController();

  bool get isLoading => isSubmitting.value;

  @override
  void onClose() {
    pincontroller.dispose();
    super.onClose();
  }


  String? validatePin(String? value) {
    if(value == null|| value.isEmpty){
      return 'Please enter digits value';
    }
    if(!GetUtils.isNum(value)){
      return 'Pin should be 6 digits';
    }
    return null;
  }

  bool validateForm() {
    final isValid = verifyPinFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    verifyPinFormKey.currentState!.save();
    return true;
  }

  Future<void> verifyEmail() async {
    if (validateForm()) {
      try {
        if(isSubmitting.value) return;
        isSubmitting.value = true;
        await _apiService.post(
          ApiConfig.verifyEmail,{
            "email":Get.arguments["email"],
            "otp":pincontroller.text
            }
            ,(data){return data;});
        SnackbarUtils.showSuccess(message:"email verified successfully");
        Get.offAllNamed(Routes.LOGIN);
      }catch (e){
        printError(info:e.toString());
        SnackbarUtils.showError(message: e.toString(),position: SnackPosition.BOTTOM);
      }finally{
        isSubmitting.value = false;
      }
    }
  }

}
