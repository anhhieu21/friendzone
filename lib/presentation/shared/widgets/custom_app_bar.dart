import 'dart:async';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatefulWidget {
  final ScrollController scrollController;
  final double expandedHeight;
  final double collapsedHeight;
  final Widget flexTitle;
  final Widget? title;
  final List<Widget>? action;
  final double? expandedTitleScale;
  final EdgeInsets? titlePadding;
  const CustomSliverAppBar(
      {super.key,
      required this.scrollController,
      required this.expandedHeight,
      required this.collapsedHeight,
      required this.flexTitle,
      this.title,
      this.action,
      this.expandedTitleScale,
      this.titlePadding});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      _streamController.sink.add(widget.scrollController.position.pixels >=
          widget.expandedHeight * 0.7);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      collapsedHeight: widget.collapsedHeight,
      centerTitle: true,
      pinned: true,
      stretch: true,
      title: widget.title,
      flexibleSpace: StreamBuilder<bool>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            final isExpand = snapshot.data ?? false;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isExpand ? 0 : 1,
              child: FlexibleSpaceBar(
                  expandedTitleScale: widget.expandedTitleScale ?? 1.2,
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  titlePadding:
                      widget.titlePadding ?? const EdgeInsets.only(top: 8.0),
                  title: widget.flexTitle),
            );
          }),
      actions: widget.action,
    );
  }
}
