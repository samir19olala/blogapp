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
      child: Text(buttonText),
    );
  }
}