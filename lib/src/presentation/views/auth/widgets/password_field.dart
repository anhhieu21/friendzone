import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final String error;
  final String? initialValue;
  final dynamic onChanged;
  final double? padding;
  const PasswordField(
      {super.key,
      required this.controller,
      this.label,
      required this.hint,
      required this.error,
      this.initialValue,
      this.onChanged,
      this.padding});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;
  _showPassword() {
    _hidePassword = !_hidePassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: _hidePassword,
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.all(widget.padding ?? 16),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: GestureDetector(
                onTap: _showPassword,
                child: Icon(_hidePassword
                    ? Ionicons.eye_off_outline
                    : Ionicons.eye_outline)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.error;
            }
            return null;
          },
        ),
      ],
    );
  }
}
