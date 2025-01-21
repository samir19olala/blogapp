import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/primary_button.dart';
import '../controllers/verifyemail_controller.dart';

class VerifyemailView extends GetView<VerifyemailController> {
  const VerifyemailView({super.key});
  @override
  Widget build(BuildContext context) {
    final PinTheme pinTheme = PinTheme(
      height: 50,
      width: 45,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      textStyle: TextStyle(
        color: Get.theme.colorScheme.primary,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Get.theme.colorScheme.primary.withOpacity(0.1),
          border: Border(
              bottom:
                  BorderSide(width: 2, color: Get.theme.colorScheme.primary))),
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text("Verify email",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "enter the digit code received to this email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Get.arguments['email'],
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(() {
                    return Form(
                      key: controller.verifyPinFormKey,
                      child: Column(
                        children: [
                          Pinput(
                            length: 6,
                            controller: controller.pincontroller,
                            validator: controller.validatePin,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                              controller.verifyEmail();
                            },
                            keyboardType: TextInputType.number,
                            defaultPinTheme: pinTheme,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomPrimaryButton(
                            buttonText: "continue",
                            onPressed: () {
                              controller.verifyEmail();
                            },
                            isSubmitting: controller.isSubmitting.value,
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
