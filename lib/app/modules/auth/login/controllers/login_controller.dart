import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordController.dispose();
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

  bool validateForm() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    loginFormKey.currentState!.save();
    return true;
  }

  Future<void> login() async {
    if (validateForm()) {
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
