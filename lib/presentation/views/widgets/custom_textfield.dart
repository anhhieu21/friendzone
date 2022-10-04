import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String error;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(16),
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
