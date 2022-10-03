import 'package:flutter/material.dart';
import 'package:friendzone/presentation/views/view.dart';
import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
            BottomNavigationBarItem(icon: Icon(Ionicons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.chatbubble), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.people), label: 'Friend'),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.person), label: 'Profile'),
          ]),
    );
  }
}
