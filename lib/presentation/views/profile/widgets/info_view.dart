import 'package:flutter/material.dart';

class InforView extends StatelessWidget {
  final String value;
  final String label;
  const InforView({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          value,
          style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(label, style: textTheme.bodyLarge),
      ],
    );
  }
}
