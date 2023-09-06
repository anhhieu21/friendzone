import 'package:flutter/material.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/domain.dart';

import 'package:go_router/go_router.dart';

import '../../../../utils/formatter.dart';
import 'box_account_center.dart';
import 'box_pravicy.dart';
import 'sub_item_setting.dart';

class ListSetting extends StatelessWidget {
  const ListSetting({super.key});
  List<Setting> _initList() =>
      listSetting.map((e) => Setting.fromMap(e)).toList();
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const BoxAccountCenter(),
      const BoxPravicyCheck(),
      ..._initList().map((e) => ItemSetting(setting: e)),
    ]);
  }
}

class ItemSetting extends StatelessWidget {
  final Setting setting;
  const ItemSetting({super.key, required this.setting});

  _handleItem(BuildContext context, Settings setting) {
    switch (setting) {
      case Settings.theme:
        context.pushNamed(Formatter.nameRoute(RoutePath.changeTheme));
        return;
      case Settings.news:
        return;
      case Settings.emotional:
        return;
      case Settings.notification:
        return;
      case Settings.navigationbar:
        return;
      case Settings.language:
        context.pushNamed(Formatter.nameRoute(RoutePath.changeLanguage));
        return;
      case Settings.media:
        return;
      case Settings.information:
        return;
      case Settings.posts:
        return;
      case Settings.newsfeed:
        return;
      case Settings.reels:
        return;
      case Settings.timeOnFriendZone:
        return;
      case Settings.terms:
        return;
      case Settings.privacy:
        return;
      case Settings.community:
        return;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      title: Text(setting.title),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          children: setting.labels
              .map((e) => SubItemSetting(
                    iconData: e.iconData,
                    label: e.label,
                    callback: () => _handleItem(context, e.setting),
                  ))
              .toList(),
        ),
      ),
      titleTextStyle:
          textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
      subtitleTextStyle:
          textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
