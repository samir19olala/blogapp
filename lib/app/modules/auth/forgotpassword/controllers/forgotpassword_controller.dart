import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ForgotpasswordController extends GetxController {
  //TODO: Implement ForgotpasswordController
final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();



  @override
  void onClose() {
    emailcontroller.dispose();
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

  bool validateForm(){
    final isValid = forgotPasswordFormKey.currentState!.validate();
    if(!isValid){
      return false;
    }
    forgotPasswordFormKey.currentState!.save();
    return true;
  }
  Future<void> forgotPassword() async {
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
