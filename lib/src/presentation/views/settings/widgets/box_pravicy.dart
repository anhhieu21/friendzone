import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/color.dart';

class BoxPravicyCheck extends StatelessWidget {
  const BoxPravicyCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colorWhite,
        boxShadow: [
          BoxShadow(
            color: colorGrey.shade300,
            blurRadius: 5.0,
            spreadRadius: 0.1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              title: const Text('Privacy Check'),
              subtitle: const Text(
                  'review important privacy and security settings as instructed'),
              titleTextStyle:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              subtitleTextStyle:
                  textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          SvgPicture.asset('assets/icons/icon_privacy.svg', width: 60)
        ],
      ),
    );
  }
}
