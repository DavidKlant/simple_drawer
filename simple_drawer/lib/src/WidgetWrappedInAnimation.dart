import 'package:flutter/material.dart';

/// Wraps a Widget with a fade in or fade out animation.
class WidgetWrappedInAnimation extends StatefulWidget {
  final Widget? child;
  final TransitionType? transitionType;
  final int? durationInMilliseconds;
  final Curve? curve;

  WidgetWrappedInAnimation(
      {this.child,
      this.transitionType,
      this.durationInMilliseconds,
      this.curve}) {
    if (child == null) {
      throw Exception("ScaleUpAnimation needs child to be set");
    }
  }

  @override
  _WidgetWrappedInAnimationState createState() =>
      _WidgetWrappedInAnimationState();
}

class _WidgetWrappedInAnimationState extends State<WidgetWrappedInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    //set default
    int durationInMilliseconds = widget.durationInMilliseconds ?? 1000;
    _animationController = AnimationController(
        duration: Duration(milliseconds: durationInMilliseconds), vsync: this)
      ..animateTo(1, duration: Duration(milliseconds: durationInMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    int durationInMilliseconds = widget.durationInMilliseconds ?? 1000;

    // set defaults
    TransitionType transitionType =
        widget.transitionType ?? TransitionType.fadeIn;
    Curve curve = widget.curve ?? Curves.ease;

    if (transitionType == TransitionType.fadeOut) {
      _animationController!.reverse(from: 1);
    }

    Animation<double> animation = CurvedAnimation(
      curve: curve,
      parent: _animationController ?? AnimationController(
          duration: Duration(milliseconds: durationInMilliseconds), vsync: this)
        ..animateTo(1, duration: Duration(milliseconds: durationInMilliseconds)),
    );

    Widget transition;
    switch (transitionType) {
      case TransitionType.fadeIn:
        {
          transition = FadeTransition(
            opacity: animation,
            child: widget.child,
          );
          break;
        }
      case TransitionType.fadeOut:
        {
          transition = FadeTransition(
            opacity: animation,
            child: widget.child,
          );
          break;
        }
    }

    return Center(child: transition);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}

enum TransitionType { fadeIn, fadeOut }
