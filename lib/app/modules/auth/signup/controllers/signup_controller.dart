import 'package:blogapp/app/core/config/api_config.dart';
import 'package:blogapp/app/core/utils/snackbar_utils.dart';
import 'package:blogapp/app/data/services/api_service.dart';
import 'package:blogapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  //todo: Implement SignupController
  final ApiService _apiService = Get.find<ApiService>();
  final Rx<bool> isSubmitting = Rx<bool>(false);
  // formulare controllers
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter your email";
    }
    if (!GetUtils.isEmail(value)) {
      return "invalid email format";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 8) {
      return "password must be at least 8 characters long";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please confirm your password";
    }
    if (value != passwordController.text) {
      return "password no match !";
    }

    return null;
  }

  bool validateForm(){
    final isValid = signUpFormKey.currentState!.validate();
    if(!isValid){
      return false;
    }
    signUpFormKey.currentState!.save();
    return true;
  }
  Future<void> signup() async {
if (validateForm()) {
      try {
        if(isSubmitting())return;
        
        isSubmitting.value = true;
        await _apiService.post<Map<String,dynamic>>(
          ApiConfig.register,
          {
            'username': emailcontroller.text.trim(),
            'email': emailcontroller.text.trim(),
            'password': passwordController.text,
          },
          (data)=>data,
        );
        // navigate to login page after signup successfull
        SnackbarUtils.showSuccess(message:"compte creer avec succes");
        Get.toNamed(
          Routes.VERIFYEMAIL,
          arguments: {
            "email":emailcontroller.text
          });
          
      }catch (e){
        SnackbarUtils.showError(message: e.toString(),title: 'Erreur de creation de compte',position: SnackPosition.BOTTOM);
      }finally{
        isSubmitting.value = false;
      }
    }
  }
}
