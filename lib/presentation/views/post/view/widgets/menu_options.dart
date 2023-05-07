import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/data/models/post.dart';
import 'package:ionicons/ionicons.dart';

class MenuOptions extends StatelessWidget {
  final Function(Enum? value) onChanged;
  const MenuOptions({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Enum>(
          onChanged: (value) => onChanged(value),
          // iconDisabledColor: Colors.grey,
          // buttonHeight: 25,
          // buttonWidth: 130,
          // buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          // buttonDecoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(14),
          //     color: colorGrey.shade300),
          // itemPadding: const EdgeInsets.all(10),
          // dropdownDecoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(14),
          //     color: colorGrey.shade300),
          // dropdownElevation: 8,
          // scrollbarRadius: const Radius.circular(40),
          // scrollbarThickness: 6,
          // scrollbarAlwaysShow: true,
          // offset: const Offset(-20, 0),
          isExpanded: true,
          hint: const Text('Tuỳ chọn'),
          items: [
            DropdownMenuItem<Enum>(
              value: OptionPost.public,
              child: Row(
                children: const [Text('Công khai'), Icon(Ionicons.earth)],
              ),
            ),
            DropdownMenuItem<Enum>(
              value: OptionPost.private,
              child: Row(
                children: const [Text('Riêng tư'), Icon(Ionicons.lock_closed)],
              ),
            ),
          ]),
    );
  }
}
