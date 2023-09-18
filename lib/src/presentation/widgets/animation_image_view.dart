import 'package:flutter/widgets.dart';
import 'package:friendzone/src/utils/constants/constants.dart';

class AnimationImageView extends StatefulWidget {
  final Widget child;
  const AnimationImageView({super.key, required this.child});

  @override
  State<AnimationImageView> createState() => _AnimationImageViewState();
}

class _AnimationImageViewState extends State<AnimationImageView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: durationAnimation)
          ..forward();
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCubic);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        alignment: Alignment.center, scale: _animation, child: widget.child);
  }
}
