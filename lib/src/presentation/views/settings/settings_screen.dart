import 'package:flutter/material.dart';
import 'package:friendzone/src/presentation/state/settings/language/language_cubit.dart';
import 'package:friendzone/src/presentation/view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text.settingPrivacy),
      ),
      body: const ListSetting(),
    );
  }
}
