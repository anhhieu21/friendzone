import 'package:flutter/material.dart';

class SiginButton extends StatelessWidget {
  final Function() onPress;
  final String label;
  const SiginButton({super.key, required this.onPress, required this.label});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 45),
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
