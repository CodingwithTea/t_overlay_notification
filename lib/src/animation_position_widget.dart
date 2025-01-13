import 'package:flutter/material.dart';

import '../t_overlay_notification.dart';

class NotificationAnimationPosition extends StatefulWidget {
  final Widget child;
  final SlideDirection? slideInDirection;
  final SlideDirection? slideOutDirection;

  const NotificationAnimationPosition({
    super.key,
    required this.child,
    this.slideInDirection,
    this.slideOutDirection,
  });

  @override
  State<NotificationAnimationPosition> createState() =>
      NotificationAnimationPositionState();
}

class NotificationAnimationPositionState
    extends State<NotificationAnimationPosition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Configure slide and fade animations
    _slideAnimation = Tween<Offset>(
      begin: _getSlideOffset(
          widget.slideInDirection ?? SlideDirection.rightToLeft),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  Offset _getSlideOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.leftToRight:
        return const Offset(-1, 0); // Start from the left
      case SlideDirection.rightToLeft:
        return const Offset(1, 0); // Start from the right
      case SlideDirection.topToBottom:
        return const Offset(0, -1); // Start from the top
      case SlideDirection.bottomToTop:
        return const Offset(0, 1); // Start from the bottom
    }
  }

  void animateOut(VoidCallback onComplete) {
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: _getSlideOffset(
          widget.slideOutDirection ?? SlideDirection.rightToLeft),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.reverse().whenComplete(onComplete);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
