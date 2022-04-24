import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String? prefixText;
  final String? label;

  const FieldText(
      {required this.controller,
      this.keyboard,
      this.prefixText,
      this.label,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboard ?? TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
          prefixText: prefixText,
        ),
      ),
    );
  }
}
