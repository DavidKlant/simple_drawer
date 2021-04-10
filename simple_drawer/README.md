# simple_drawer

simple_drawer offers an easy way to implement your own widget as a drawer which slides in from any direction (top, bottom, left & right).

<img src="https://i.imgur.com/iX9H15n.gif" width="240" height="520"/>
<img src="https://i.imgur.com/VtV6YRA.gif" width="240" height="357"/>

## Getting Started

**To use: Add a SimpleDrawer at the end of a Stack & activate it by calling "SimpleDrawer.activate(id);" anywhere.**
You can call "SimpleDrawer.deactivate(id);" to disable the drawer remotely.

A SimpleDrawer has various arguments to modify it (only 4 required):

- (**required**) **id** (String) (Identifies the drawer; can be any String you choose.)
- (**required**) **direction** (Direction) (Specifies the direction from which the drawer enters. E.g.: Direction.top)
- (**required**) **child** (Widget) (The content of the drawer.)

- (**one required**) **childWidth** & **childHeight** (double) (The width and height of the child passed in pixels. For Direction.top & .bottom childHeight is requires. For Direction.left & .right childWidth is required)

- (optional) **animationDurationInMilliseconds** (int) (Duration which it takes for the drawer to completely slide in and out. Default: 300)
- (optional) **animationCurve** (Curve) (Curve which the drawer takes to slide in and out. Default: Curves.ease)
- (optional) **fadeColor** (Colors) (Color which is overlaid behind the SimpleDrawer to obscure content. Default: Colors.black54)
- (optional) **simpleDrawerAreaHeight** & **simpleDrawerAreaWidth** (double) (Restrictions on how much space to total widget (i.e. drawer + Conatiner with fadeColor) can take up. Default: device height & width)

You can also use SimpleDrawer.getDrawerStatus(id) to get the current status of any SimpleDrawer.

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
      // set one simpleDrawer sliding in from the bottom
      Widget bottomSimpleDrawer = SimpleDrawer(
        child: Container(
          // round the corners & set color
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.green,
          ),
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