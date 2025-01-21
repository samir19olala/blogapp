import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isSubmitting;
  const CustomPrimaryButton({
  super.key, 
  required this.buttonText, 
  required this.onPressed,
  this.isSubmitting=false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
        minimumSize: const Size(double.infinity,48),
        // fixedSize: Size(
        //   double.infinity,48)
      ),
      child:isSubmitting?const CircularProgressIndicator(color: Colors.white,): Text(buttonText), 

        // child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // children:[Text(buttonText),SizedBox(width: 10,),Icon(Icons.insert_comment_sharp)]),
    );
  }
}