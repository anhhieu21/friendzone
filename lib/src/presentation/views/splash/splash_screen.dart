import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/shared.dart';
import 'package:friendzone/src/presentation/state.dart';

import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _checkAuth());
  }

  _checkAuth() async {
    context.read<AuthBloc>().add(AuthInitialEvent());
  }

  _listenAuthState(String id) {
    BlocProvider.of<MyAccountCubit>(context, listen: false)
        .myAccountInfo(id)
        .then((value) {
      if (!value) return;
      CustomOverlayEntry.instance.hideOverlay();
      context.replace(RoutePath.main);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) _listenAuthState(state.id);
        if (state is Loading) {
          CustomOverlayEntry.instance.loadingCircularProgressIndicator(context);
        }
        if (state is AuthError || state is UnAuthenticated) {
          CustomOverlayEntry.instance.hideOverlay();
        }
      },
      child: Scaffold(
        body: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Ionicons.logo_deviantart),
              Text('Welcome to Friend Zone')
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: OnTapEffect(
              onTap: () => context.push(RoutePath.signin),
              radius: 16,
              child: Ink(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: colorPinkButton,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorWhite, fontWeight: FontWeight.w600),
                  ))),
        ),
      ),
    );
  }
}
