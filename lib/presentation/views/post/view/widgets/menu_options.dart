import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';

class MenuOptions extends StatelessWidget {
  const MenuOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
          onChanged: (value) {},
          iconDisabledColor: Colors.grey,
          buttonHeight: 25,
          buttonWidth: 130,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: colorGrey.shade300),
          itemPadding: const EdgeInsets.all(10),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: colorGrey.shade300),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
          isExpanded: true,
          hint: const Text('Tuỳ chọn'),
          items: [
            DropdownMenuItem<String>(
              value: 'sfdsd',
              child: Row(
                children: const [Text('Công khai'), Icon(Icons.public)],
              ),
            ),
            DropdownMenuItem<String>(
              value: 'sfdsd',
              child: Row(
                children: const [Text('Công khai'), Icon(Icons.public)],
              ),
            ),
          ]),
    );
  }
}
