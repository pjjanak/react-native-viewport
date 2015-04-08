# react-native-viewport
Utility to get current size of the viewport.

## Add it to your project

1. Run `npm install react-native-viewport --save`
2. Open your project in XCode, right click on `Libraries` and click `Add Files to "Your Project Name"`.
3. Navigate to `node_modules/react-native-viewport`
4. Select `Viewport.xcodeproj`
5. Add `libViewport.a` to `Build Phases -> Link Binary With Libraries`.
6. Click on `Viewport.xcodeproj` in `Libraries` and go the `Build Phases` tab. Double click the text to the right of `Header Search Paths` and verify that it has `$(SRCROOT)../react-native/React` - if it isn't, then add it. This is so XCode is able to find the headers that the `Viewport` source files are referring to by pointing to the header files installed within the `react-native` `node_modules` directory.
7. Whenever you want to use it within React code now you can: `var Viewport = require('react-native-viewport');`

## Methods
***
Note that any time you receive dimensions you will be given an object formatted like so:

```
{
	width: 120,
	height: 120
}
```
***

`addEventListener(eventName, callback)`

>Adds an event listener to the backing viewport manager. Will call the provided callback whenever the event is fired.

>Currently the only supported event is `dimensionsDidChange`. As a convenience, you can reference this event via `Viewport.events.DEVICE_DIMENSIONS_EVENT`. This event fires whenever the dimensions of the screen change (e.g. a screen rotation).

`removeEventListener(eventName, callback)`

>Removes an event listener from the backing viewport manager. Will only remove listeners with the exact name and callback specified.

`getDimensions(callback)`

>Gets the current dimensions and passes them to the specified callback. This is useful if you ever want to get dimensions in an adhoc way, such as when the app first boots up and before you have the chance to attach a listener.

  