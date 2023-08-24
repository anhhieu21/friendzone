import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:friendzone/presentation/views/settings/widgets/sub_item_setting.dart';
import 'package:ionicons/ionicons.dart';

class BoxAccountCenter extends StatelessWidget {
  const BoxAccountCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Account center'),
            subtitle: const Text(
                'manage the account section and connect experience on FriendZone\'s technologies'),
            titleTextStyle:
                textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            subtitleTextStyle:
                textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SubItemSetting(
              iconData: Ionicons.document_outline,
              label: 'personal information',
              callback: () {},
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SubItemSetting(
              iconData: Ionicons.lock_closed_outline,
              label: 'password and security',
              callback: () {},
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'More in account center',
                style: textTheme.bodyLarge!
                    .copyWith(color: colorBlue, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}