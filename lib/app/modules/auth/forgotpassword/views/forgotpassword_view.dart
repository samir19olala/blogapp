import 'package:flutter/material.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import 'package:get/get.dart';

import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  const ForgotpasswordView({super.key});
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
              key: controller.forgotPasswordFormKey,
              child: Column(
                children: [
                  Text(
                    'You \'re forgot your password',
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
                    'enter your email and will your a link to reset your password',
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
                    height: 24,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomPrimaryButton(
                    buttonText: "Continue",
                    onPressed: () {
                      controller.forgotPassword();
                    },
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
