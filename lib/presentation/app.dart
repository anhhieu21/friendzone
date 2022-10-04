import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/domain/repositories/auth_repository.dart';
import 'package:friendzone/presentation/bloc/auth_bloc.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:friendzone/presentation/views/main_screen.dart';
import 'package:friendzone/presentation/views/signin/view/bloc/signup_bloc.dart';
import 'package:friendzone/presentation/views/signin/view/sign_up_screen.dart';
import 'package:friendzone/presentation/views/signin/view/sign_in_screen.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) =>
                SignUpBloc(RepositoryProvider.of<AuthRepository>(context)),
          )
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: 'FriendZone',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            routerConfig: _router,
          ),
        ),
      ),
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
          return const SignUpScreen();
        },
      ),
    ],
  );
}
