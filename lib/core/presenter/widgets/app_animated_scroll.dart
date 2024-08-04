import 'package:flutter/material.dart';

class AppAnimatedScroll extends StatefulWidget {
  final Widget child;

  const AppAnimatedScroll({
    required this.child,
    super.key,
  });

  @override
  State<AppAnimatedScroll> createState() => _AppAnimatedScrollState();
}

class _AppAnimatedScrollState extends State<AppAnimatedScroll>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  double _scrollPosition = 0.0;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          _scrollPosition += _forward ? 5 : -5;
          _scrollController.jumpTo(_scrollPosition);

          if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
            _forward = false;
          } else if (_scrollPosition <=
              _scrollController.position.minScrollExtent) {
            _forward = true;
          }
        });
      });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: widget.child,
    );
  }
}
