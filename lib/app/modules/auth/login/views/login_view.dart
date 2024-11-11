import 'package:blogapp/app/modules/widgets/custom_text_field.dart';
import 'package:blogapp/app/modules/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            Center(
              child: Text(
                'Login here',
                style: TextStyle(
                  fontSize:Get.theme.textTheme.headlineLarge!.fontSize,
                  color:Get.theme.primaryColor),
              ),
            ),
            const SizedBox(height: 16,),            
            Center(
              child: Text(
                'Welcome back you\' ve been missed',
                style: TextStyle(
                  fontSize:Get.theme.textTheme.headlineMedium!.fontSize,
                ),
              ),
            ),
            const SizedBox(height: 24,),
            CustomTextFromField(
              controller: controller.emailcontroller,
              hintText: 'Enter your email',
              isPassword: false, 
              textInputType: TextInputType.emailAddress,
               labelText: 'Email',
               validator: (String? value){
                return controller.validateEmail(value);
               }
               ),

               const SizedBox(height: 16,),

            CustomTextFromField(
              controller: controller.passwordController,
              hintText: 'Enter your password',
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              labelText: 'Password',
              suffixIcon: Icons.visibility_off,
              validator: (String? value){
                return controller.validatePassword(value);
               },),
               const SizedBox(height:24,),
               
              CustomPrimaryButton(buttonText: "Sign In",
              onPressed: (){},)
          ],
        ),
      ),
    );
  }
}
