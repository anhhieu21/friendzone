import 'package:flutter/material.dart';

class InforView extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? callback;
  const InforView({
    Key? key,
    required this.value,
    required this.label,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: callback,
      child: Column(
        children: [
          Text(
            value,
            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(label, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}
