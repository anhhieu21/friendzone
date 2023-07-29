import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:friendzone/data.dart';
import 'package:friendzone/data/repositories/conversation_repository.dart';
import 'package:friendzone/data/repositories/feed_repository.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/theme.dart';
import 'package:friendzone/presentation/utils/formatter.dart';
import 'package:friendzone/presentation/view.dart';
import 'package:friendzone/presentation/views/chats/view/conversation_screen.dart';
import 'package:friendzone/presentation/views/home/view/feed_detail_screen.dart';
import 'package:friendzone/presentation/views/home/view/up_new_feed.dart';
import 'package:friendzone/presentation/views/home/widgets/post_detail.dart';
import 'package:friendzone/state.dart';
import 'package:friendzone/state/profile/user/user_cubit.dart';
import 'package:go_router/go_router.dart';

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
                ChatsCubit(RepositoryProvider.of<ConversationRepository>(_)),
          )
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => primaryFocus?.unfocus(),
          child: MaterialApp.router(
            title: 'FriendZone',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            routerConfig: router,
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

  final multiblocProvider = [];
  final GoRouter router = GoRouter(
    // navigatorKey: navigatorKey,
    routes: [
      GoRoute(
          path: RoutePath.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen()),
      GoRoute(
          path: RoutePath.signin,
          builder: (BuildContext context, GoRouterState state) =>
              SignInScreen()),
      GoRoute(
          path: RoutePath.signup,
          builder: (BuildContext context, GoRouterState state) =>
              const SignUpScreen()),
      GoRoute(
          path: RoutePath.main,
          builder: (BuildContext context, GoRouterState state) =>
              const MainScreen(),
          routes: [
            GoRoute(
                path: RoutePath.writepost,
                name: Formatter.nameRoute(RoutePath.writepost),
                builder: (BuildContext context, GoRouterState state) =>
                    WritePost()),
            GoRoute(
                path: RoutePath.updateProfile,
                name: Formatter.nameRoute(RoutePath.updateProfile),
                builder: (BuildContext context, GoRouterState state) =>
                    UpdateProfileScreen(userDetail: state.extra as UserModel)),
            GoRoute(
                path: RoutePath.postDetail,
                name: Formatter.nameRoute(RoutePath.postDetail),
                builder: (BuildContext context, GoRouterState state) =>
                    PostDetailScreen(post: state.extra as Post)),
            GoRoute(
                path: RoutePath.profileDetail,
                name: Formatter.nameRoute(RoutePath.profileDetail),
                builder: (BuildContext context, GoRouterState state) =>
                    ProfileDetailScreen(id: state.extra as String)),
            GoRoute(
                path: RoutePath.conversentation,
                name: Formatter.nameRoute(RoutePath.conversentation),
                builder: (BuildContext context, GoRouterState state) =>
                    ConversationScreen(
                      userModel: state.extra as UserModel,
                    )),
            GoRoute(
                path: RoutePath.upFeed,
                name: Formatter.nameRoute(RoutePath.upFeed),
                builder: (BuildContext context, GoRouterState state) =>
                    const UpNewFeedScreen()),
            GoRoute(
                path: RoutePath.detailFeed,
                name: Formatter.nameRoute(RoutePath.detailFeed),
                builder: (BuildContext context, GoRouterState state) =>
                    FeedDetailScreen(
                      currentPage: (state.extra ?? 0) as int,
                    ))
          ]),
    ],
  );
}
