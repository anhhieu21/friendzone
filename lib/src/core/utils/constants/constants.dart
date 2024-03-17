import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// key colection
const kUser = 'users';
const kPost = 'post';
const kFeed = 'feed';

//key sub-colection
const kComment = 'comment';
const kLike = 'like';
const kConversation = 'conversation';
const kFollower = 'follower';
const kFollowing = 'following';
const kPostSave = 'postSave';

//key config
const kKeyApiWeather = 'keyApiWeather';

// message
const savePostMsg = 'Đã lưu bài viết';
const unSavePostMsg = 'Đã bỏ lưu bài viết';
const loginFailMsg = 'Đăng nhập không thành công';
const loginSuccessMsg = 'Đăng nhập thành công';

// key local-storage
const kTheme = 'theme';
const kLanguageCode = 'languageCode';

// duration
const durationAnimation = Duration(milliseconds: 500);

// key sharedPreferences
const kUserName = 'userName';
const kPassword = 'password';

// Border radius
BorderRadius kBorderRadius = BorderRadius.circular(16.0);
const kBorderRadiusOnTop = BorderRadius.vertical(top: Radius.circular(16.0));

// Button size
const kIconBtnSize = 24.0; // default

const kHeightCover = kToolbarHeight * 3.2;
const kHeightAppBar = kHeightCover;

const kAppBarBottomSize = kToolbarHeight * 2.5;

// Gradient
LinearGradient kGradient = LinearGradient(
  // begin: Alignment.topCenter,
  tileMode: TileMode.clamp,
  // end: Alignment.bottomCenter,
  begin: const Alignment(0.0, 0.0),
  end: const Alignment(0.0, 0.6),
  colors: [
    Colors.grey.withOpacity(0.0),
    Colors.grey.withOpacity(0.1),
    Colors.grey.withOpacity(0.3),
    Colors.grey.withOpacity(0.5),
  ],
);
