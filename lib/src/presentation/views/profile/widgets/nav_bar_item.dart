import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import 'nav_bar.dart';

// Handle the transition between selected and de-deselected, by animating it's own width,
// and modifying the color/visibility of some child widgets
class NavbarButton extends StatefulWidget {
  final NavBarItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  const NavbarButton(
      {super.key,
      required this.data,
      required this.isSelected,
      required this.onTap});

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimController;
  bool? _wasSelected;
  final double _animScale = 1;

  @override
  void initState() {
    //Create a tween + controller which will drive the icon rotation
    int duration = (350 / _animScale).round();
    _iconAnimController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );
    Tween<double>(begin: 0, end: 1)
        .animate(_iconAnimController)
        //Listen for tween updates, and rebuild the widget tree on each tick
        .addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _startAnimIfSelectedChanged(widget.isSelected);
    //Create our main button, a Row, with an icon and some text
    //Inject the data from our widget.data property
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Rotate the icon using the current animation value
        Rotation3d(
          rotationY: 180 * _iconAnimController.value,
          child: Icon(
            widget.data.icon,
            size: 24,
            color: widget.isSelected ? Colors.white : const Color(0xffcccccc),
          ),
        ),
        //Add some hz spacing
        const SizedBox(width: 12),
        //Label
        Text(
          widget.data.title,
          style: const TextStyle(color: Colors.white, fontFamily: "Montserrat"),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 4, left: 4),
        //Wrap in an animated container, so changes to width & color automatically animate into place
        child: AnimatedContainer(
          alignment: Alignment.center,
          //Determine target width, selected item is wider
          width: widget.isSelected ? widget.data.width : 56,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(12),
          duration: Duration(milliseconds: (700 / _animScale).round()),
          //Use BoxDecoration top create a rounded container
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.data.selectedColor
                : Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          //Wrap the row in a ClippedView to suppress any overflow errors if we momentarily exceed the screen size
          child: ClippedView(
            child: content,
          ),
        ),
      ),
    );
  }

  void _startAnimIfSelectedChanged(bool isSelected) {
    if (_wasSelected != widget.isSelected) {
      //Go forward or reverse, depending on the isSelected state
      widget.isSelected
          ? _iconAnimController.forward()
          : _iconAnimController.reverse();
    }
    _wasSelected = widget.isSelected;
  }
}

//Takes a x,y or z rotation, in degrees, and rotates. Good for spins & 3d flip effects
class Rotation3d extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  const Rotation3d(
      {Key? key,
      required this.child,
      this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(rotationX * degrees2Radians)
          ..rotateY(rotationY * degrees2Radians)
          ..rotateZ(rotationZ * degrees2Radians),
        child: child);
  }
}
