import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:ionicons/ionicons.dart';

class MenuOptions extends StatelessWidget {
  final Function(Enum? value) onChanged;
  const MenuOptions({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Enum>(
          onChanged: (value) => onChanged(value),
          buttonStyleData: ButtonStyleData(
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: colorGrey.shade200)),
          dropdownStyleData: DropdownStyleData(
              offset: const Offset(0, -10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0))),
          isExpanded: true,
          hint: const Text('Tuỳ chọn '),
          items: const [
            DropdownMenuItem<Enum>(
              value: OptionPost.public,
              child: Row(
                children: [Text('Công khai'), Icon(Ionicons.earth)],
              ),
            ),
            DropdownMenuItem<Enum>(
              value: OptionPost.private,
              child: Row(
                children: [Text('Riêng tư'), Icon(Ionicons.lock_closed)],
              ),
            ),
          ]),
    );
  }
}
