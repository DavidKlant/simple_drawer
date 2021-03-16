# simple_drawer

Flutter package simple_drawer.

## Getting Started

simple_drawer offers an easy way to implement your own drawer sliding in from any side (top, bottom, left & right).

**To use, add a SimpleDrawer at the end of a Stack & activate it by calling "SimpleDrawer.activate(id);" anywhere.**
You can call "SimpleDrawer.deactivate(id);" to disable the drawer remotely.

A SimpleDrawer has various arguments to modify it:

- (required) **id** (String) (Identifies the drawer; can be any String you choose.)
- (required) **direction** (Direction) (Specifies the direction from which the drawer enters. E.g.: Direction.top)
- (required) **child** (Widget) (The content of the drawer.)

- (one required) **childWidth** & **childHeight** (double) (The width and height of the child passed in pixels. For Direction.top & .bottom childHeight is requires. For Direction.left & .right childWidth is required)

- (optional) **animationDurationInMilliseconds** (int) (Duration which it takes for the drawer to completely slide in and out. Default: 300)
- (optional) **animationCurve** (Curve) (Curve which the drawer takes to slide in and out. Default: Curves.ease)
- (optional) **fadeColor** (Colors) (Color which is overlaid behind the SimpleDrawer to obscure content. Default: Colors.black54)
- (optional) **simpleDrawerAreaHeight** & **simpleDrawerAreaWidth** (double) (Restrictions on how much space to total widget (i.e. drawer + Conatiner with fadeColor) can take up. Default: device height & width)

### Example

```dart
void main() {
  runApp(MaterialApp(
    home: MyApp2(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    {
      // set one SimpleDrawer from bottom
      Widget bottomSimpleDrawer = SimpleDrawer(
        child: Container(
          color: Colors.green,
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
        childHeight: 300,
        direction: Direction.bottom,
        id: "bottom",
      );

      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    SimpleDrawer.activate("bottom");
                  },
                  child: Text("bottom")),
            ),
            bottomSimpleDrawer,
          ],
        ),
      );
    }
  }
}
```