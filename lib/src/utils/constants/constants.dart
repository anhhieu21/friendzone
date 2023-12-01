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
