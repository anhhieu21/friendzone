// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Setting {
  String title;
  List<Labels> labels;
  Setting({
    required this.title,
    required this.labels,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'labels': labels.map((x) => x.toMap()).toList(),
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      title: map['title'] as String,
      labels: List<Labels>.from(
        (map['labels'] as List).map<Labels>(
          (x) => Labels.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) =>
      Setting.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Labels {
  String label;
  IconData iconData;
  Settings setting;
  Labels({
    required this.label,
    required this.iconData,
    required this.setting,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'iconData': iconData.codePoint,
    };
  }

  factory Labels.fromMap(Map<String, dynamic> map) {
    return Labels(
      label: map['label'] as String,
      iconData: map['iconData'],
      setting: map['setting'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Labels.fromJson(String source) =>
      Labels.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum Themes {
  light('Light'),
  dark('Dark'),
  system('Default system');

  final String label;
  const Themes(this.label);
}

enum Settings {
  theme,
  news,
  emotional,
  notification,
  navigationbar,
  language,
  media,
  information,
  posts,
  newsfeed,
  reels,
  timeOnFriendZone,
  terms,
  privacy,
  community
}

final listSetting = [
  {
    'title': 'Option',
    'labels': [
      {'label': 'theme', 'iconData': Ionicons.moon, 'setting': Settings.theme},
      {'label': 'news', 'iconData': Ionicons.options, 'setting': Settings.news},
      {
        'label': 'emotional options',
        'iconData': Ionicons.heart,
        'setting': Settings.emotional
      },
      {
        'label': 'notification',
        'iconData': Ionicons.notifications,
        'setting': Settings.notification
      },
      {
        'label': 'navigation bar',
        'iconData': Ionicons.grid,
        'setting': Settings.navigationbar
      },
      {
        'label': 'language and region',
        'iconData': Ionicons.language,
        'setting': Settings.language
      },
      {
        'label': 'files and media',
        'iconData': Ionicons.folder,
        'setting': Settings.media
      },
    ]
  },
  {
    'title': 'Object and display mode',
    'labels': [
      {
        'label': 'information on personal page',
        'iconData': Ionicons.person_circle,
        'setting': Settings.information
      },
      {
        'label': 'posts',
        'iconData': Ionicons.newspaper,
        'setting': Settings.posts
      },
      {
        'label': 'newsfeed',
        'iconData': Ionicons.reader,
        'setting': Settings.newsfeed
      },
      {
        'label': 'reels',
        'iconData': Ionicons.albums,
        'setting': Settings.reels
      },
      {
        'label': 'your time on FriendZone',
        'iconData': Ionicons.time,
        'setting': Settings.timeOnFriendZone
      },
    ]
  },
  {
    'title': 'Community standards and legal policy',
    'labels': [
      {
        'label': 'terms of service',
        'iconData': Ionicons.book,
        'setting': Settings.terms
      },
      {
        'label': 'privacy policy',
        'iconData': Ionicons.ribbon,
        'setting': Settings.privacy
      },
      {
        'label': 'community standards',
        'iconData': Ionicons.shield,
        'setting': Settings.community
      },
    ]
  },
];
