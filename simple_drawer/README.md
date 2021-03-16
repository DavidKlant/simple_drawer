# simple_drawer

Flutter package simple_drawer.

## Getting Started

simple_drawer offers an easy way to implement your own drawer sliding in from any side (top, bottom, left & right).

To use, add a SimpleDrawer at the end of a stack & activate it by calling "SimpleDrawer.activate(id);" anywhere.

A SimpleDrawer has various arguments to modify it:
- (required) id (String) (Identifies the drawer; can be any String you choose.)
- (required) direction (Direction) (Specifies the direction from which the drawer enters. E.g.: Direction.top)
- (required) child (Widget) (The content of the drawer.)

- (one required) childWidth & childHeight (double) (The width and height of the child passed in pixels. For Direction.top & .bottom childHeight is requires. For Direction.left & .right childWidth is required)

- (optional) animationDurationInMilliseconds (int) (Duration which it takes for the drawer to completely slide in and out. Default: 300)
- (optional) animationCurve (Curve) (Curve which the drawer takes to slide in and out. Default: Curves.ease)
- (optional) fadeColor (Colors) (Color which is overlaid behind the SimpleDrawer to obscure content. Default: Colors.black54)
- (optional) simpleDrawerAreaHeight & simpleDrawerAreaWidth (double) (Restrictions on how much space to total widget (i.e. drawer + Conatiner with fadeColor) can take up. Default: device height & width)

### Example

```dart
import 'package:flutter/material.dart';
import 'package:splash_tap/splash_tap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Tap Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashTapDemo(),
    );
  }
}

class SplashTapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Splash(
          onTap: () {},
          child: Text(
            'Splash!',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
```