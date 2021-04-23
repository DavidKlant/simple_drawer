## [0.0.1] - 2021-03-16

* simple_drawer offers an easy way to implement your own widget as a drawer which slides in from any direction (top, bottom, left & right).
* Pop your own widget into a SimpleDrawer and it can slide in from any direction. The background will be obscured by a color which fades in.
* Offers customization of fadeColor, animationCurve & Duration & area where the widget widget is shown.

## [0.0.2] - 2021-03-19

* add example
* format code (using dart format)
* refactor functionality of simpleDrawerAreaHeight & Width to perform bug-free when user inputs certain faulty data (too large child size)
* refactor description

## [0.0.3] - 2021-03-20

* add gifs

## [0.0.4] - 2021-03-20

* change gif sizes

## [0.0.5] - 2021-03-20

* fix images (0.0.4 broke them)

## [0.0.6] - 2021-04-10

* add function isActive, so the user can get the current status of any SimpleDrawer
* hide _idToStreamController (formerly idToStreamController) from user

## [0.0.7] - 2021-04-10

* switch function isActive for getDrawerStatus, which represents the status more accurately.
* Update example to include getDrawerStatus

## [0.0.8] - 2021-04-10

* fix library (to include DrawerStatus)

## [0.0.9] - 2021-04-22

* add onDrawerStatusChanged as an argument (This function is called whenever the DrawerStatus of this SimpleDrawer changes. Receives the new DrawerStatus as an argument.)

## [0.0.10] - 2021-04-23

* fix bug, where an event could have been added to a disposed StreamController