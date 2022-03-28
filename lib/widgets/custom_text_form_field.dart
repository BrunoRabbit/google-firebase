import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool isObscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isNeedContrast;
  final String hintText;
  final Widget suffixIcon;

  const CustomTextFormField({
    Key? key,
    required this.isObscureText,
    required this.controller,
    this.validator,
    required this.isNeedContrast,
    required this.hintText,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 15,
      ),
      child: TextFormField(
        obscureText: isObscureText,
        controller: controller,
        validator: validator,
        cursorColor: Colors.black54,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 12,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black54,
          ),
          suffixIcon: suffixIcon,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.deepOrangeAccent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
