import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/config.dart';
import 'package:friendzone/src/presentation/state/cubit/reel_cubit.dart';
import 'package:friendzone/src/utils.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/menu.dart';
import '../widgets/button_bar_reel.dart';
import '../widgets/toolbar_reel.dart';
import '../widgets/video_reel.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  _handleButtonBar(MenuReels value) {
    switch (value) {
      case MenuReels.like:
        break;
      case MenuReels.comment:
        break;
      case MenuReels.create:
        context.pushNamed(Formatter.nameRoute(RoutePath.createReel));
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReelCubit, ReelState>(
      builder: (context, state) {
        if (state is AllReel) {
          final list = state.list;
          return PageView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (_, i) {
                return currentPage == i
                    ? Stack(
                        children: [
                          VideoReel(reel: list[i]),
                          const ToolBarReel(),
                          ButtonBarReel(onPressed: _handleButtonBar),
                        ],
                      )
                    : const SizedBox();
              });
        }
        return const SizedBox();
      },
    );
  }
}
