import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:friendzone/presentation/views/main_screen.dart';
import 'package:friendzone/presentation/views/signin/sign_up_screen.dart';
import 'package:friendzone/presentation/views/signin/view/sign_in_screen.dart';
import 'package:friendzone/presentation/views/view.dart';
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
    routes: [
      GoRoute(
          path: RoutePath.main,
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
          routes: [
            GoRoute(
              path: RoutePath.home,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
                path: RoutePath.profile,
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfileScreen();
                })
          ]),
      GoRoute(
        path: RoutePath.signin,
        builder: (BuildContext context, GoRouterState state) {
          return SignInScreen();
        },
      ),
      GoRoute(
        path: RoutePath.signup,
        builder: (BuildContext context, GoRouterState state) {
          return SignUpScreen();
        },
      ),
    ],
  );
}
