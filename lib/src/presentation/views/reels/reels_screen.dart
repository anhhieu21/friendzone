import 'package:flutter/material.dart';

import '../../../domain/models/menu.dart';
import 'widgets/button_bar_reel.dart';
import 'widgets/toolbar_reel.dart';
import 'widgets/video_reel.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  _handleButtonBar(MenuReels value) {
    //
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: 3,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        itemBuilder: (_, i) {
          return currentPage == i
              ? Stack(
                  children: [
                    const VideoReel(),
                    const ToolBarReel(),
                    ButtonBarReel(onPressed: _handleButtonBar),
                  ],
                )
              : const SizedBox();
        });
  }
}
