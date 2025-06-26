import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final String buttonText;
  final TextEditingController controller;
  final String labelText;

  const TextFieldButton({
    super.key,
    required this.buttonText,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: buttonText,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}
