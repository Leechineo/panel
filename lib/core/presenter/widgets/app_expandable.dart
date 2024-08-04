import 'package:flutter/material.dart';

class AppExpandable extends StatefulWidget {
  final Widget? body;
  final bool isExpanded;

  const AppExpandable({required this.isExpanded, this.body, super.key});

  @override
  State<AppExpandable> createState() => _AppExpandableState();
}

class _AppExpandableState extends State<AppExpandable>
    with TickerProviderStateMixin {
  // control the state of the animation
  late final AnimationController _controller;

  // animation that generates value depending on tween applied
  late final Animation<double> _animation;

  // define the begin and the end value of an animation
  late final Tween<double> _sizeTween;

  // expansion state
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);

    _isExpanded = widget.isExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
    super.initState();
  }
  
  @override
  void didUpdateWidget(AppExpandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      // Update the _isExpanded variable and trigger the animation
      setState(() {
        _isExpanded = widget.isExpanded;
        _isExpanded ? _controller.forward() : _controller.reverse();
      });
    }
  }

  // dispose the controller to release it from the memory
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeTween.animate(_animation),
      // a widget given to the StatefulWidget
      child: widget.body,
    );
  }
}
