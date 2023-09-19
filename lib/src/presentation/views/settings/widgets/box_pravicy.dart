import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoxPravicyCheck extends StatelessWidget {
  const BoxPravicyCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
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
