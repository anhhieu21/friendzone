import 'package:flutter/widgets.dart';
import 'package:friendzone/src/utils/constants/constants.dart';

class AnimationPopupMenu extends StatefulWidget {
  final Widget child;
  const AnimationPopupMenu({super.key, required this.child});

  @override
  State<AnimationPopupMenu> createState() => _AnimationPopupMenuState();
}

class _AnimationPopupMenuState extends State<AnimationPopupMenu>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: durationAnimation)
          ..forward();
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutSine);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
          alignment: Alignment.topCenter,
          scale: _animation,
          child: widget.child),
    );
  }
}
