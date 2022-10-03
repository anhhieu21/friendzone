import 'package:flutter/material.dart';
import 'package:friendzone/presentation/routes/path.dart';
import 'package:friendzone/presentation/themes/color.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Text('data'),
            ElevatedButton(
                onPressed: () => GoRouter.of(context).go(RoutePath.signin),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: colorPinkButton.shade400,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text(
                  'Login',
                  style: TextStyle(color: colorWhite),
                ))
          ],
        ),
      ),
    );
  }
}
