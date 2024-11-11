import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFromField extends StatefulWidget {
  final TextEditingController controller;
  final IconData? suffixIcon;
  final String hintText;
  final bool isPassword;
  final String labelText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const CustomTextFromField(
      {super.key,
      required this.controller,
      this.suffixIcon,
      required this.hintText,
      required this.isPassword,
      required this.textInputType,
      this.validator, required this.labelText});

  @override
  State<CustomTextFromField> createState() => _CustomTextFromField();
}

class _CustomTextFromField extends State<CustomTextFromField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null && widget.isPassword
            ? IconButton(
                onPressed: _toggleObscureText,
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off))
            : null,
        label: Text(widget.labelText),
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
