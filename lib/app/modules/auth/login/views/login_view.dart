import 'package:blogapp/app/modules/widgets/custom_text_field.dart';
import 'package:blogapp/app/modules/widgets/primary_button.dart';
import 'package:blogapp/app/modules/widgets/secondary_button.dart';
import 'package:blogapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
              key: controller.loginFormKey,
              child: Column(
                children: [
                  Text(
                    'Login here',
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
                    'Welcome back you\' ve been missed',
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
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: ButtonStyle(),
                      child: const Text(
                        'forgot your password ?',
                      ),
                      onPressed: () => Get.toNamed(Routes.FORGOTPASSWORD),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(() {
                    return CustomPrimaryButton(
                      isSubmitting: controller.isSubmitting.value,
                      buttonText: "Sign In",
                      onPressed: () {
                        controller.login();
                      },
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomSecondaryButton(
                    buttonText: "Create new account",
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
