import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/data.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/presentation/state.dart';
import 'package:friendzone/src/presentation/state/chat/conversation/conversation_cubit.dart';
import 'package:friendzone/src/presentation/view.dart';
import 'package:friendzone/src/utils/formatter.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                  RepositoryProvider.of<UserRepository>(_))),
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
            create: (_) =>
                PostCubitCubit(RepositoryProvider.of<PostRepository>(_)),
          ),
          BlocProvider(
            create: (_) =>
                UserPreviewCubit(RepositoryProvider.of<UserRepository>(_)),
          ),
          BlocProvider(
            create: (_) =>
                ChatCubit(RepositoryProvider.of<ConversationRepository>(_)),
          ),
          BlocProvider(
            create: (_) =>
                ConversationCubit(RepositoryProvider.of<ConversationRepository>(_)),
          ),
          BlocProvider(
            create: (_) => AppThemeCubit(),
          ),
          BlocProvider(
            create: (_) => LanguageCubit(),
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
                path: RoutePath.writepost,
                name: Formatter.nameRoute(RoutePath.writepost),
                builder: (_, state) => WritePost()),
            GoRoute(
                path: RoutePath.updateProfile,
                name: Formatter.nameRoute(RoutePath.updateProfile),
                builder: (_, state) =>
                    UpdateProfileScreen(userDetail: state.extra as UserModel)),
            GoRoute(
                path: RoutePath.postDetail,
                name: Formatter.nameRoute(RoutePath.postDetail),
                builder: (_, state) =>
                    PostDetailScreen(post: state.extra as Post)),
            GoRoute(
                path: RoutePath.profileDetail,
                name: Formatter.nameRoute(RoutePath.profileDetail),
                builder: (_, state) =>
                    ProfileDetailScreen(id: state.extra as String)),
            GoRoute(
                path: RoutePath.conversentation,
                name: Formatter.nameRoute(RoutePath.conversentation),
                builder: (_, state) => ConversationScreen(
                      userModel: state.extra as UserModel,
                    )),
            GoRoute(
                path: RoutePath.upFeed,
                name: Formatter.nameRoute(RoutePath.upFeed),
                builder: (_, state) => const UpNewFeedScreen()),
            GoRoute(
                path: RoutePath.detailFeed,
                name: Formatter.nameRoute(RoutePath.detailFeed),
                builder: (_, state) => FeedDetailScreen(
                      currentPage: (state.extra ?? 0) as int,
                    )),
            GoRoute(
                path: RoutePath.settings,
                name: Formatter.nameRoute(RoutePath.settings),
                builder: (_, state) => const SettingsScreen()),
            GoRoute(
                path: RoutePath.changeTheme,
                name: Formatter.nameRoute(RoutePath.changeTheme),
                builder: (_, state) => const ChangeThemeScreen()),
            GoRoute(
                path: RoutePath.changeLanguage,
                name: Formatter.nameRoute(RoutePath.changeLanguage),
                builder: (_, state) => ChangeLanguageScreen())
          ]),
    ],
  );
}
