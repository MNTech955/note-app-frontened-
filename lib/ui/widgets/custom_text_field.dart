import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? obsecureText;
  const CustomTextField({super.key, required this.hint, this.controller, this.obsecureText=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        obscureText: obsecureText!,
        controller: controller,
        decoration:
            InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}
