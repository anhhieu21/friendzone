import 'package:flutter/material.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:friendzone/presentation/views/home/view/home_screen.dart';
import 'package:friendzone/presentation/views/signin/view/sign_in_screen.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FriendZone',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/signin',
        builder: (BuildContext context, GoRouterState state) {
          return SignInScreen();
        },
      ),
    ],
  );
}
