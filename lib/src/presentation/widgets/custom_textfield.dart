import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hint;
  final String error;
  final String? initialValue;
  final dynamic onChanged;
  final double? padding;
  final bool? readOnly;
  final TextInputType? keyboardType;
  const CustomTextField(
      {super.key,
      this.controller,
      this.label,
      required this.hint,
      required this.error,
      this.initialValue,
      this.onChanged,
      this.readOnly,
      this.padding,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: keyboardType,
          readOnly: readOnly ?? false,
          initialValue: initialValue,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.all(padding ?? 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return error;
            }
            return null;
          },
        ),
      ],
    );
  }
}
