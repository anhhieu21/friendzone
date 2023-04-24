import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:friendzone/domain/repositories/auth_repository.dart';
import 'package:friendzone/domain/repositories/post_repository.dart';
import 'package:friendzone/domain/repositories/user_repository.dart';
import 'package:friendzone/presentation/bloc/auth_bloc.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:friendzone/presentation/views/home/bloc/cubit/new_feeds_cubit.dart';
import 'package:friendzone/presentation/views/main_screen.dart';
import 'package:friendzone/presentation/views/profile/cubit/myaccount/my_account_cubit.dart';
import 'package:friendzone/presentation/views/profile/view/update_profile.dart';
import 'package:friendzone/presentation/views/signin/view/bloc/signup_bloc.dart';
import 'package:friendzone/presentation/views/signin/view/sign_up_screen.dart';
import 'package:friendzone/presentation/views/signin/view/sign_in_screen.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:go_router/go_router.dart';

import 'views/home/bloc/allpost/all_post_cubit.dart';
import 'views/post/cubit/write_post_cubit.dart';
import 'views/profile/cubit/update/update_profile_cubit.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository.instance),
        RepositoryProvider(create: (context) => PostRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) =>
                SignUpBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
              create: (context) => WritePostCubit(
                  RepositoryProvider.of<PostRepository>(context))),
          BlocProvider(
              create: (context) => AllPostCubit(
                  RepositoryProvider.of<PostRepository>(context),
                  RepositoryProvider.of<UserRepository>(context))),
          BlocProvider(
              create: (context) => NewFeedsCubit(
                  RepositoryProvider.of<PostRepository>(context))),
          BlocProvider(
              create: (context) => UpdateProfileCubit(
                  RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider(
              create: (context) => MyAccountCubit(
                  RepositoryProvider.of<UserRepository>(context))),
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: 'FriendZone',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            routerConfig: _router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'US')],
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
          routes: <RouteBase>[
            GoRoute(
              path: RoutePath.home,
              builder: (BuildContext context, GoRouterState state) {
                return  HomeScreen();
              },
            ),
            GoRoute(
              path: RoutePath.writepost,
              builder: (BuildContext context, GoRouterState state) {
                return WritePost();
              },
            ),
            GoRoute(
              path: RoutePath.profile,
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileScreen();
              },
            ),
            GoRoute(
                path: RoutePath.updateProfile,
                builder: (BuildContext context, GoRouterState state) {
                  return UpdateProfileScreen(userDetail: state.extra as User);
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
