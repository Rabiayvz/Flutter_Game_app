import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
final controller;
final String hintText;
final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: TextField(
        controller: controller, //access the information
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
