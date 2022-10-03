import 'package:flutter/material.dart';
import 'package:friendzone/common/extentions/size_extention.dart';
import 'package:friendzone/presentation/themes/color.dart';

class SiginButton extends StatelessWidget {
  final Function() onPress;
  final String label;
  const SiginButton({super.key, required this.onPress, required this.label});

  @override
  Widget build(BuildContext context) {
    final size = BuildContextX(context).screenSize;

    return Container(
      width: size.width,
      height: 55,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: colorPinkButton.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 5)),
      ]),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            backgroundColor: colorPinkButton.shade300),
        child:  Text(
          label,
          style:const TextStyle(fontWeight: FontWeight.bold, color: colorWhite),
        ),
      ),
    );
  }
}
