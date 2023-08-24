import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});
  final langs = [
    {"code": "en", "name": "English"},
    {"code": "vi", "name": "Vietnamese"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: Column(
        children: langs
            .map((e) => Row(
                  children: [
                    Text(e['name'].toString()),
                    const Icon(Ionicons.ellipse_outline)
                  ],
                ))
            .toList(),
      ),
    );
  }
}
