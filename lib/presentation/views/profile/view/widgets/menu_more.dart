import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';

class MenuDrop extends StatelessWidget {
  const MenuDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          shadowColor: colorGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: (context, item, isSelected) => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: const Text(
            'item.title',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      itemAsString: (category) => category.toString(),
      items: ['Cài đặt', 'Đăng xuất'],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
          fillColor: colorGrey.shade300,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
