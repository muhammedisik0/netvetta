import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.inputAction,
    this.keyboardType,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      obscureText: obscureText ?? false,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      keyboardType: keyboardType,
      textInputAction: inputAction,
      controller: controller,
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1.5, color: Colors.black),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF3D3D3D),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
