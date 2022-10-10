import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/presentation/views/signin/view/sign_in_screen.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:ionicons/ionicons.dart';

import 'home/bloc/allpost/all_post_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  @override
  void initState() {
    BlocProvider.of<AllPostCubit>(context).getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              extendBody: true,
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: const [
                  HomeScreen(),
                  ProfileScreen(),
                  HomeScreen(),
                  ProfileScreen()
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: (value) {
                    setState(() => _selectedIndex = value);
                    _pageController.jumpToPage(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.chatbubble), label: 'Chat'),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.people), label: 'Friend'),
                    BottomNavigationBarItem(
                        icon: Icon(Ionicons.person), label: 'Profile'),
                  ]),
            );
          }
          return SignInScreen();
        });
  }
}
