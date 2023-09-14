import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/app_bloc_observer.dart';
import 'package:friendzone/firebase_options.dart';
import 'package:friendzone/src/data/services/fcm.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'src/presentation/app.dart';
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: scopes,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      name: 'FriendZone', options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
