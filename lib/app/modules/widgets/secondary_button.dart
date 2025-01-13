import 'package:flutter/material.dart';

class CustomSecondaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const CustomSecondaryButton({
  super.key, 
  required this.buttonText, 
  this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity,48),
      ),
      child:Text(buttonText),
    );
  }
}