import 'package:flutter/material.dart';
import 'package:friendzone/presentation/views/home/view/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: [HomeScreen()],
      ),
    );
  }
}
