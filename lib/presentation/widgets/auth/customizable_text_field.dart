// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomizableTextField extends StatelessWidget {
  Color fillColor;
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  final Function(String)? onSubmitted;

  CustomizableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    this.fillColor = const Color.fromARGB(14, 0, 0, 0),
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onSubmitted: onSubmitted,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '◉',
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        filled: true,
      ),
    );
  }
}
