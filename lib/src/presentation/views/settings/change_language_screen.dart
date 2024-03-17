import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';

import 'package:ionicons/ionicons.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});
  final langs = [
    {"code": "en", "name": text.english},
    {"code": "vi", "name": text.vietnamese},
  ];
  _setLanguage(BuildContext _, String code) {
    _.read<LanguageCubit>().changeLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text.language),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: langs
              .map((e) => OnTapEffect(
                    onTap: () => _setLanguage(context, e['code'].toString()),
                    radius: 12.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(e['name'].toString())),
                          text.localeName == e['code']
                              ? const Icon(
                                  Ionicons.checkmark_circle_sharp,
                                )
                              : const Icon(Ionicons.ellipse_outline)
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
