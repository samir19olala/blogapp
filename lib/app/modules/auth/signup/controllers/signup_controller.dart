import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

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
    if(validateForm()){
      //TODO: Implement Signup API call
      // You can use a package like http to make the API call
      //...
      // Example:
      // await http.post('https://your-api-url.com/signup', body: {
      //   'email': emailController.text,
      //   'password': passwordController.text

    }
  }
}
