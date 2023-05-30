import 'package:flutter/material.dart';

class ExtendedBlackScreenTransitionsBuilder extends PageTransitionsBuilder {
  final Duration blackScreenDuration;

  ExtendedBlackScreenTransitionsBuilder({this.blackScreenDuration = const Duration(milliseconds: 1000)});

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!route.willHandlePopInternally && route.isFirst) {
      return child;
    }

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          if (animation.status == AnimationStatus.completed) {
            // Return the new screen without any transition effect
            return child!;
          }

          // Show a black screen during the initial phase of the transition
          return DelayedBlackScreen(
            duration: blackScreenDuration,
            child: child!,
          );
        },
        child: child,
      ),
    );
  }
}

class DelayedBlackScreen extends StatefulWidget {
  final Duration duration;
  final Widget child;

  DelayedBlackScreen({required this.duration, required this.child});

  @override
  _DelayedBlackScreenState createState() => _DelayedBlackScreenState();
}

class _DelayedBlackScreenState extends State<DelayedBlackScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Transition completed, navigate to the new screen
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => widget.child));
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
