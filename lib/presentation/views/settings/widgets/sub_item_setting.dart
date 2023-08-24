import 'package:flutter/material.dart';
import 'package:friendzone/presentation/shared.dart';
import 'package:friendzone/presentation/themes/color.dart';

class SubItemSetting extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback callback;
  const SubItemSetting({
    Key? key,
    required this.iconData,
    required this.label,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnTapEffect(
      onTap: callback,
      radius: 12.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 24,
              color: colorBlack.withOpacity(0.6),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(label),
            ))
          ],
        ),
      ),
    );
  }
}
