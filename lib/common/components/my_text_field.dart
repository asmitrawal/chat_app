// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          validator: validator,),
    );
  }
}
