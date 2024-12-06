import 'package:blogapp/app/modules/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/app/modules/widgets/custom_text_field.dart';
import 'package:blogapp/app/modules/widgets/primary_button.dart';
import 'package:blogapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints:
                const BoxConstraints(maxWidth: 500), // Set max width to 400px
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 50), // Optional padding
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: Get.theme.textTheme.headlineLarge!.fontSize,
                      color: Get.theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Create an account so you can access all the features',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.theme.textTheme.headlineSmall!.fontSize,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFromField(
                      controller: controller.emailcontroller,
                      hintText: 'Enter your email',
                      isPassword: false,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      validator: (String? value) {
                        return controller.validateEmail(value);
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFromField(
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    isPassword: true,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    suffixIcon: Icons.visibility_off,
                    validator: (String? value) {
                      return controller.validatePassword(value);
                    },
                  ),
                  const SizedBox(height: 16,),

                  CustomTextFromField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm password',
                    isPassword: true,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Repeat Password',
                    suffixIcon: Icons.visibility_off,
                    validator: (String? value) {
                      return controller.validateConfirmPassword(value);
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomPrimaryButton(
                    buttonText: "Sign Up",
                    onPressed: () {
                      controller.signup();
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomSecondaryButton(
                    buttonText: 'already have account',
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
