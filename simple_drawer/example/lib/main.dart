import 'package:flutter/material.dart';
import 'package:simple_drawer/simple_drawer.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
      // SimpleDrawer from the bottom & with border Radius
      Widget bottomSimpleDrawer = SimpleDrawer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.green,
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 300,
        ),
        childHeight: 300,
        direction: Direction.bottom,
        id: "bottom",
      );

      // SimpleDrawer from the right
      Widget rightSimpleDrawer = SimpleDrawer(
        child: Container(
          color: Colors.green,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: 200,
        ),
        childWidth: 200,
        direction: Direction.right,
        id: "right",
      );

      // SimpleDrawer from the left
      Widget leftSimpleDrawer = SimpleDrawer(
        child: Container(
          color: Colors.green,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: 150,
        ),
        childWidth: 150,
        direction: Direction.left,
        id: "left",
      );

      // SimpleDrawer from the top
      Widget topSimpleDrawer = SimpleDrawer(
        child: Container(
          color: Colors.green,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 300,
        ),
        childHeight: 300,
        direction: Direction.top,
        id: "top",
      );

      // SimpleDrawer from the left with different fadeColor
      Widget leftSimpleDrawerFadeColorAltered = SimpleDrawer(
        child: Container(
          color: Colors.green,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: 150,
        ),
        childWidth: 150,
        direction: Direction.left,
        id: "fadeColor",
        fadeColor: Colors.blue.withOpacity(0.5),
      );

      // SimpleDrawer from the left with altered animationCurve and Duration
      Widget leftSimpleDrawerAnimationCurveAndDuration = SimpleDrawer(
        child: Container(
          color: Colors.green,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: 150,
        ),
        childWidth: 150,
        direction: Direction.left,
        id: "animation",
        animationCurve: Curves.bounceIn,
        animationDurationInMilliseconds: 800,
      );

      // SimpleDrawer from the left with altered simpleDrawerAreaHeight & Width
      Widget leftSimpleDrawerArea = SimpleDrawer(
        child: Container(
          color: Colors.green,
          height: 300,
          width: 100,
        ),
        childWidth: 100,
        direction: Direction.left,
        id: "area",
        simpleDrawerAreaHeight: 300,
        simpleDrawerAreaWidth: 200,
      );

      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("right");
                      },
                      child: Text("right")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("bottom");
                      },
                      child: Text("bottom")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("left");
                      },
                      child: Text("left")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("top");
                      },
                      child: Text("top")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("fadeColor");
                      },
                      child: Text("different fadeColor")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("animation");
                      },
                      child: Text("different animationCurve and Duration")),
                  ElevatedButton(
                      onPressed: () {
                        SimpleDrawer.activate("area");
                      },
                      child: Text("altered simpleDrawerAreaHeight & Width")),
                ],
              ),
            ),
            rightSimpleDrawer,
            bottomSimpleDrawer,
            leftSimpleDrawer,
            topSimpleDrawer,
            leftSimpleDrawerFadeColorAltered,
            leftSimpleDrawerAnimationCurveAndDuration,
            Center(child: leftSimpleDrawerArea),
          ],
        ),
      );
    }
  }
}
