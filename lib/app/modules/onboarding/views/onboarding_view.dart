import 'package:blogapp/app/modules/widgets/logo.dart';
import 'package:blogapp/app/modules/widgets/primary_button.dart';
import 'package:blogapp/app/modules/widgets/secondary_button.dart';
import 'package:blogapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height:50),
            const LogoApp(),
            const SizedBox(height: 100),
            Text(
              'Discover your favorite blog',
              style: TextStyle(
                color: Get.theme.primaryColor, 
                fontSize: Get.textTheme.headlineLarge!.fontSize),
            ),
            const SizedBox(height: 40),
            const Text(
              'Explore all your favorite blog in one place',
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomPrimaryButton(
                  buttonText: 'Login',
                  onPressed: ()=> Get.toNamed(Routes.LOGIN),
                ),
                const SizedBox(width: 20),
                CustomSecondaryButton(
                  buttonText: 'Register',
                  onPressed: () =>{},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
