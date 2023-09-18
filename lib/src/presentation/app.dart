// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/data/repositories/reel_repository.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/presentation/views/reels/view/create_reel_screen.dart';

import 'state/chat/conversation/conversation_cubit.dart';
import 'state/cubit/reel_cubit.dart';
import 'views/profile/view/user_profile_detail_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository.instance),
        RepositoryProvider(create: (_) => PostRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => ConversationRepository()),
        RepositoryProvider(create: (_) => FeedRepository()),
        RepositoryProvider(create: (_) => ReelRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(RepositoryProvider.of<AuthRepository>(_)),
          ),
          BlocProvider(
              create: (_) =>
                  WritePostCubit(RepositoryProvider.of<PostRepository>(_))),
          BlocProvider(
              create: (_) => AllPostCubit(
                    RepositoryProvider.of<PostRepository>(_),
                  )),
          BlocProvider(
              create: (_) =>
                  FeedCubit(RepositoryProvider.of<FeedRepository>(_))),
          BlocProvider(
              create: (_) =>
                  UpdateProfileCubit(RepositoryProvider.of<UserRepository>(_))),
          BlocProvider(
              create: (_) =>
                  MyAccountCubit(RepositoryProvider.of<UserRepository>(_))),
          BlocProvider(
            create: (_) => PostCubit(RepositoryProvider.of<PostRepository>(_)),
          ),
          BlocProvider(
            create: (_) =>
                UserPreviewCubit(RepositoryProvider.of<UserRepository>(_)),
          ),
          BlocProvider(
            create: (_) => ChatCubit(
                RepositoryProvider.of<ConversationRepository>(_),
                RepositoryProvider.of<UserRepository>(_)),
          ),
          BlocProvider(
            create: (_) => ConversationCubit(
                RepositoryProvider.of<ConversationRepository>(_)),
          ),
          BlocProvider(
            create: (_) => AppThemeCubit(),
          ),
          BlocProvider(
            create: (_) => LanguageCubit(),
          ),
          BlocProvider(
            create: (_) => ReelCubit(RepositoryProvider.of<ReelRepository>(_)),
          )
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => primaryFocus?.unfocus(),
          child: BlocSelector<AppThemeCubit, AppThemeState, ThemeData>(
            selector: (state) {
              if (state is ChangedTheme) {
                return state.themeData;
              }
              return AppTheme.lightTheme;
            },
            builder: (context, theme) {
              return BlocSelector<LanguageCubit, LanguageState, Locale>(
                selector: (state) {
                  if (state is ChangeLanguage) {
                    return state.locale;
                  }
                  return const Locale('en');
                },
                builder: (_, locale) {
                  return MaterialApp.router(
                    title: 'FriendZone',
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    locale: locale,
                    // darkTheme: AppTheme.darkTheme,
                    // themeMode: ThemeMode.system,
                    routerConfig: router,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  final multiblocProvider = [];
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
          path: RoutePath.splash, builder: (_, state) => const SplashScreen()),
      GoRoute(path: RoutePath.signin, builder: (_, state) => SignInScreen()),
      GoRoute(
          path: RoutePath.signup, builder: (_, state) => const SignUpScreen()),
      GoRoute(
          path: RoutePath.main,
          builder: (_, state) => const MainScreen(),
          routes: [
            GoRoute(
                name: RoutePath.routeName(RoutePath.writepost),
                path: RoutePath.writepost,
                builder: (_, state) => WritePost()),
            GoRoute(
                name: RoutePath.routeName(RoutePath.updateProfile),
                path: RoutePath.updateProfile,
                builder: (_, state) =>
                    UpdateProfileScreen(userDetail: state.extra as UserModel)),
            GoRoute(
                name: RoutePath.routeName(RoutePath.postDetail),
                path: RoutePath.postDetail,
                pageBuilder: (_, state) => _slideTransitionPage(
                    PostDetailScreen(post: state.extra as Post))),
            GoRoute(
                name: RoutePath.routeName(RoutePath.profileDetail),
                path: RoutePath.profileDetail,
                builder: (_, state) =>
                    ProfileDetailScreen(id: state.extra as String)),
            GoRoute(
                name: RoutePath.routeName(RoutePath.conversentation),
                path: RoutePath.conversentation,
                builder: (_, state) => ConversationScreen(
                      userModel: state.extra as UserModel,
                    )),
            GoRoute(
                name: RoutePath.routeName(RoutePath.upFeed),
                path: RoutePath.upFeed,
                builder: (_, state) => const UpNewFeedScreen()),
            GoRoute(
                name: RoutePath.routeName(RoutePath.detailFeed),
                path: RoutePath.detailFeed,
                builder: (_, state) => FeedDetailScreen(
                      currentPage: (state.extra ?? 0) as int,
                    )),
            GoRoute(
                name: RoutePath.routeName(RoutePath.settings),
                path: RoutePath.settings,
                builder: (_, state) => const SettingsScreen()),
            GoRoute(
                name: RoutePath.routeName(RoutePath.changeTheme),
                path: RoutePath.changeTheme,
                builder: (_, state) => const ChangeThemeScreen()),
            GoRoute(
                name: RoutePath.routeName(RoutePath.changeLanguage),
                path: RoutePath.changeLanguage,
                builder: (_, state) => ChangeLanguageScreen()),
            GoRoute(
                name: RoutePath.routeName(RoutePath.createReel),
                path: RoutePath.createReel,
                builder: (_, state) => const CreateReelScreen())
          ]),
    ],
  );

}
CustomTransitionPage<dynamic> _slideTransitionPage(Widget child) {
  return CustomTransitionPage(
      child: child,
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
