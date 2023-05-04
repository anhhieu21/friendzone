import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
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

  _checkAuth() {
    if (FirebaseAuth.instance.currentUser != null) {
      context.replace(RoutePath.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Ionicons.logo_deviantart),
            Text('Welcome to Friend Zone')
          ],
        ),
      ),
    );
  }
}
