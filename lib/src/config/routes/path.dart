class RoutePath {
  static const String splash = '/';
  static const String main = '/main';
  static const String writepost = 'main/upPost';
  static const String updateProfile = 'main/updateProfile';
  static const String settings = 'main/settings';
  static const String changeTheme = 'main/changeTheme';
  static const String changeLanguage = 'main/changeLanguage';
  static const String createReel = 'main/createReel';
  static const String postDetail = 'main/postDetail';
  static const String profileDetail = 'main/profileDetail';
  static const String conversentation = 'main/conversentation';
  static const String upFeed = 'main/upFeed';
  static const String chat = 'main/chat';
  static const String detailFeed = 'main/detailFeed';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String newConversation = 'main/newConversation';

  static routeName(String path) => path.substring(5);
}
