import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const CustomPrimaryButton({
  super.key, 
  required this.buttonText, 
  this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
        fixedSize: Size(
          double.infinity,48)
      ),
      child: Text(buttonText),
    );
  }
}