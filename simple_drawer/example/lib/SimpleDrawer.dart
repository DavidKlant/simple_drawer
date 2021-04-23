import 'dart:async';
import 'dart:collection';

import 'package:example/Direction.dart';
import 'package:example/DrawerStatus.dart';
import 'package:example/WidgetWrappedInAnimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// SimpleDrawer-Widget which can be pushed in from all four sides
class SimpleDrawer extends StatefulWidget {
  /// Map which holds a StreamController for each unique SimpleDrawer
  static Map<String, StreamController<String>> _idToStreamController =
      HashMap();
  static Map<String, DrawerStatus> _idToStatus = HashMap();
  static Map<String, Function> _idToOnStatusChanged = HashMap();

  /// returns the current status of a drawer
  static DrawerStatus getDrawerStatus(String id) {
    if (_idToStatus[id] == null) {
      return DrawerStatus.inactive;
    }
    return _idToStatus[id];
  }

  static void _setDrawerStatus(String id, DrawerStatus drawerStatus) {
    SimpleDrawer._idToStatus[id] = drawerStatus;
    if (_idToOnStatusChanged[id] != null) {
      try {
        _idToOnStatusChanged[id](drawerStatus);
      } catch (e) {
        print(
            "Error while running onDrawerStatusChanged. This function receives exactly one argument, which is a DrawerStatus");
      }
    }
  }

  /// activates the SimpleDrawer of the chosen Id & set isActive to true
  static activate(String id) {
    if (_idToStreamController[id] == null ||
        _idToStreamController[id].isClosed) {
      return;
    }
    _idToStreamController[id].add("activate");
  }

  /// deactivates the SimpleDrawer of the chosen Id & set isActive to false
  static deactivate(String id) {
    if (_idToStreamController[id] == null ||
        _idToStreamController[id].isClosed) {
      return;
    }
    _idToStreamController[id].add("deactivate");
  }

  /// unique id chosen for a SimpleDrawer (chosen by user)
  /// (if this is changed, you must perform at least a hot reload)
  /// (must be set)
  final String id;

  /// the direction from which the SimpleDrawer enters
  /// (must be set)
  final Direction direction;

  /// the content of the SimpleDrawer (what is being pushed in)
  /// (must be set)
  final Widget child;

  /// the width of the child.
  /// (must be set if direction is Direction.left or .right)
  final double childWidth;

  /// the height of the child.
  /// (must be set if direction is Direction.top or .bottom)
  final double childHeight;

  /// the duration in milliseconds which it takes for the simpleDrawer to be
  ///     pushed in & pushed out
  /// (optional argument. default: 300)
  final int animationDurationInMilliseconds;

  /// the animation curve which the simpleDrawer takes to push in and out
  /// (optional argument. default: Curves.ease)
  final Curve animationCurve;

  /// the maximum height which the entire widget (including the fading
  /// background) can take up
  /// (optional argument. default: entire device height)
  final double simpleDrawerAreaHeight;

  /// the maximum width which the entire widget (including the fading
  /// background) can take up
  /// (optional argument. default: entire device width)
  final double simpleDrawerAreaWidth;

  /// The color which is overlaid behind the simpleDrawer
  /// to obscure the content in the background.
  /// (optional argument. default: Colors.black54)
  final Color fadeColor;

  /// This function is called whenever the DrawerStatus of this SimpleDrawer
  /// changes.
  /// Receives the new DrawerStatus as an argument.
  final Function onDrawerStatusChanged;

  SimpleDrawer(
      {this.direction,
      this.childWidth,
      this.childHeight,
      this.animationDurationInMilliseconds,
      this.animationCurve,
      this.child,
      this.simpleDrawerAreaHeight,
      this.simpleDrawerAreaWidth,
      this.fadeColor,
      this.id,
      this.onDrawerStatusChanged}) {
    if (id == null) {
      throw Exception("id can not be null");
    }
    if (direction == null) {
      throw Exception("direction can not be null");
    }
    if ((direction == Direction.bottom || direction == Direction.top) &&
        this.childHeight == null) {
      throw Exception(
          "childHeight must not be null for Direction.top and Direction.bottom");
    }
    if ((direction == Direction.left || direction == Direction.right) &&
        this.childWidth == null) {
      throw Exception(
          "childWidth must not be null for Direction.left and Direction.right");
    }

    SimpleDrawer._idToOnStatusChanged[this.id] = this.onDrawerStatusChanged;
  }

  @override
  _SimpleDrawerState createState() => _SimpleDrawerState();
}

class _SimpleDrawerState extends State<SimpleDrawer> {
  bool isShown = false;
  bool isActive = false;

  @override
  void initState() {
    // init the StreamController
    SimpleDrawer._idToStreamController[widget.id] = StreamController<String>();

    // listen to the StreamController for events "activate" & "deactivate"
    SimpleDrawer._idToStreamController[widget.id].stream.listen((event) {
      if (event == "activate") {
        activateSimpleDrawer();
      }
      if (event == "deactivate") {
        deactivateSimpleDrawer();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // close SteamController
    SimpleDrawer._idToStreamController[widget.id].close();

    super.dispose();
  }

  /// retracts the pushing
  void deactivateSimpleDrawer() {
    // start retracting
    setState(() {
      isShown = false;
    });

    // set status to retracting
    SimpleDrawer._setDrawerStatus(widget.id, DrawerStatus.retracting);

    // once retracting is done set isActive to false, so some widgets are not
    // rendered & set status to inactive
    int durationInMilli = widget.animationDurationInMilliseconds ?? 300;
    Timer(Duration(milliseconds: durationInMilli), () {
      SimpleDrawer._setDrawerStatus(widget.id, DrawerStatus.inactive);
      setState(() {
        isActive = false;
      });
    });
  }

  /// pushes in the pushIN
  void activateSimpleDrawer() {
    // set drawerStatus to sliding in
    SimpleDrawer._setDrawerStatus(widget.id, DrawerStatus.slidingIn);

    // after slide in is done -> set status to active
    int durationInMilli = widget.animationDurationInMilliseconds ?? 300;
    Timer(Duration(milliseconds: durationInMilli), () {
      SimpleDrawer._setDrawerStatus(widget.id, DrawerStatus.active);
    });

    // activate
    setState(() {
      isShown = true;
      isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get device measurements
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    // set defaults
    int durationInMilli = widget.animationDurationInMilliseconds ?? 300;
    Curve animationCurve = widget.animationCurve ?? Curves.ease;
    double maxWidth = widget.simpleDrawerAreaWidth ?? deviceWidth;
    double maxHeight = widget.simpleDrawerAreaHeight ?? deviceHeight;

    return Container(
      width: maxWidth,
      height: maxHeight,
      child: ClipRRect(
        child: Stack(
          children: [
            fadeContainer(durationInMilli, animationCurve, maxWidth, maxHeight),
            simpleDrawer(durationInMilli, animationCurve, maxWidth, maxHeight),
          ],
        ),
      ),
    );
  }

  /// build the Column or Row containing the widget.child depending of the
  /// chosen Direction
  Widget simpleDrawer(int durationInMilli, Curve animationCurve,
      double maxWidth, double maxHeight) {
    Widget simpleDrawer;

    switch (widget.direction) {
      case Direction.bottom:
        {
          simpleDrawer = Column(
            children: [
              contractor(durationInMilli, animationCurve, maxWidth, maxHeight),
              (isActive) ? widget.child : Container()
            ],
          );
          break;
        }
      case Direction.top:
        {
          // set pushingWidget
          Widget pushingWidget = AnimatedContainer(
            duration: Duration(milliseconds: durationInMilli),
            curve: animationCurve,
            height: (isShown) ? widget.childHeight : 0,
          );

          // return Structure for Direction.top with Position
          simpleDrawer = Positioned(
            top: -widget.childHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pushingWidget,
                widget.child,
                contractor(
                    durationInMilli, animationCurve, maxWidth, maxHeight),
              ],
            ),
          );
          break;
        }
      case Direction.left:
        {
          // set pushingWidget
          Widget pushingWidget = AnimatedContainer(
            duration: Duration(milliseconds: durationInMilli),
            curve: animationCurve,
            width: (isShown) ? widget.childWidth : 0,
          );

          // return Structure for Direction.left with Position
          simpleDrawer = Positioned(
            left: -widget.childWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pushingWidget,
                (isActive) ? widget.child : Container(),
                contractor(
                    durationInMilli, animationCurve, maxWidth, maxHeight),
              ],
            ),
          );
          break;
        }
      case Direction.right:
        {
          simpleDrawer = Row(
            children: [
              contractor(durationInMilli, animationCurve, maxWidth, maxHeight),
              (isActive) ? widget.child : Container()
            ],
          );
          break;
        }
    }

    return simpleDrawer;
  }

  /// builds the gestureDetector to deactivate the widget
  ///     for Direction.bottom & .right also functions to push in the
  ///     SimpleDrawerWidget
  Widget contractor(int durationInMilli, Curve animationCurve, double maxWidth,
      double maxHeight) {
    double touchToRetractWidth;
    double touchToRetractHeight;

    // set touchToRetractWidget for Direction.top & .bottom
    if (widget.direction == Direction.top ||
        widget.direction == Direction.bottom) {
      touchToRetractWidth = (isShown) ? maxWidth : 0;
      touchToRetractHeight =
          (isShown) ? maxHeight - widget.childHeight : maxHeight;
    }

    // set touchToRetractWidget for Direction.left & .right
    if (widget.direction == Direction.left ||
        widget.direction == Direction.right) {
      touchToRetractWidth = (isShown) ? maxWidth - widget.childWidth : maxWidth;
      touchToRetractHeight = (isShown) ? maxHeight : 0;
    }

    Widget touchToRetractWidget = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        SimpleDrawer.deactivate(widget.id);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: durationInMilli),
        curve: animationCurve,
        width: touchToRetractWidth,
        height: touchToRetractHeight,
      ),
    );

    return touchToRetractWidget;
  }

  /// builds the fading container in the background (grey by default)
  Widget fadeContainer(int durationInMilli, Curve animationCurve,
      double maxWidth, double maxHeight) {
    // set default color
    Color fadeColor = widget.fadeColor ?? Colors.black54;

    // set greyContainer
    Widget greyContainer = Container(
      height: maxHeight,
      width: maxWidth,
      color: fadeColor,
    );

    // animate greyContainer according to the state of isShown(fading out or in)
    if (!isShown) {
      greyContainer = WidgetWrappedInAnimation(
        child: greyContainer,
        durationInMilliseconds: durationInMilli,
        curve: animationCurve,
        transitionType: TransitionType.fadeOut,
      );
    } else {
      greyContainer = WidgetWrappedInAnimation(
        child: greyContainer,
        durationInMilliseconds: durationInMilli,
        curve: animationCurve,
        transitionType: TransitionType.fadeIn,
      );
    }

    // only show greyContainer if popUp isActive
    return (isActive) ? greyContainer : Container();
  }
}
