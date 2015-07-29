# DRDoubleTapButton

[![Version](https://img.shields.io/cocoapods/v/DoubleTapButton.svg?style=flat)](http://cocoapods.org/pods/DoubleTapButton)
[![License](https://img.shields.io/cocoapods/l/DoubleTapButton.svg?style=flat)](http://cocoapods.org/pods/DoubleTapButton)
[![Platform](https://img.shields.io/cocoapods/p/DoubleTapButton.svg?style=flat)](http://cocoapods.org/pods/DoubleTapButton)

A button in two steps.

Custom component for iOS that requires two taps: the first one to activate it and the second one to confirm the action.

It has a feedback label after the confirm button is called. 

**Confirm button calls a function**. When it returns true, button interaction ends with success message. When it returns false, the button is reset.

## Screenshots

When the action is success, the interaction ends after the confirm button is pushed <br />
![DoubleTapButton-1.gif](http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-1.gif)

When the action is error, the button is reseted <br />
![DoubleTapButton-2.gif](http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-2.gif)

Buttons can be tapped or swipped <br />
![DoubleTapButton-3.gif](http://diegorueda.es/code/assets/images/iOSComponents/DoubleTapButton-3.gif)

## Usage

DoubleTapButton is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following lines to your Podfile:

```ruby
use_frameworks!
pod "DoubleTapButton"
```

Then run a `pod install` inside your terminal, or from CocoaPods.app.

## Setup

If you want to use storyboards, just drop a UIView into your storyboard and set its class to `DoubleTapButton`. Then you can customize it through the attributes inspector. 
Otherwise, you can write the code to initialize with frame and set the properties.

## Properties
```swift
/// Frame properties
    
/** Corner Radius of the frame
    Default to empty (no radius) */
var borderRadius: CGFloat 

/** Border Width of the frame
    Default to empty (no border) */
var borderWidth: CGFloat 

/** Border Color of the frame
    Default to empty (no color) */
var borderColor: UIColor?


/// Common Buttons properties

/// To move the button horizontally outside the frame
var horizontalSlide: CGFloat

/// To move the button vertically outside the frame
var verticalSlide: CGFloat

/// To return button to its original position after slide it
var originalCenter: CGPoint!

/// Duration of the button slide animation
var animationDuration: NSTimeInterval = 0.5

/** Controls the sliding direction for the buttons. 
    If true, buttons slide horizontal
    If false, buttons slides vertical 
    Default: slides horizontally */
var slidesHorizontally: Bool = true


/// Primary Button properties

/** Controls if the primary button reacts to a single tap or to pan gesture
    Default: false - only reacts to pan gesture */
var reactsToTap: Bool = false

/** Text for the primary button 
    Be sure that it fits the button 
    Default to "DO SOMETHING" */
var primaryText: String = "DO SOMETHING"

/** Text color for the primary button 
    Be sure that it's different than primaryBgColor to make it readable
    Default to blue */
var primaryTxtColor: UIColor? = UIColor.blueColor()

/** Background color for the primary button
    Be sure that it's different than primaryTxtColor to make it readable
    Default to white */
var primaryBgColor: UIColor? = UIColor.whiteColor()

/** Name of the background image of the primary button
    Only implemented for primaryButton (adds an image that gives feedback to user that is draggable)
    If empty, no image is applied
    Default to empty */
var bgImageName: String = ""


/// Confirm Button properties

/** Text for the confirm button
    Be sure that it fits the button
    Default to "CONFIRM" */
var confirmText: String = "CONFIRM"

/** Text color for the confirm button
    Be sure that it's different than confirmBgColor to make it readable */
var confirmTxtColor: UIColor = UIColor.whiteColor()

/// Background color for the confirm button. Be sure that it's different than confirmTxtColor to make it readable
var confirmBgColor: UIColor = UIColor.whiteColor()


/// Function to call in confirm button

/** Function that calls the confirm button
    You must define it in code (IBInspectable doesn't accept function type)
    It must be a reference to a function wich returns a boolean, but you can change the implementation
    
    @remark Just be sure to change it also in **confirmTap()** when it is used. Default to (() -> true)
    
    Functions can be assigned in the ViewController in this way:
    
    @code
        func redButtonPushed() -> Bool {
        /// Do something and then return boolean
        return false
        }
    @endcode
*/
var functionToCall: () -> Bool = { return false }


/// Label properties

/** Text for label when confirm button returns a success message
    Defatul to "SUCCESS" */
var successText: String = "SUCCESS"

/** Text color for label when confirm button returns a success message
    Default to green */
var successTxtColor: UIColor? = UIColor.greenColor()

/** Background color for label when confirm button returns a success message
    Default to white */
var successBgColor: UIColor? = UIColor.whiteColor()

/** Text for label when confirm button returns an error message
    Default to "ERROR" */
var errorText: String = "ERROR"

/** Text color for label when confirm button returns an error message
    Default to red */
var errorTxtColor: UIColor? = UIColor.redColor()

/** Background color for label when confirm button returns an error message
    Default to white */
var errorBgColor: UIColor? = UIColor.whiteColor()
```

## Author
Diego Rueda, talkto@diegorueda.es

## License
DoubleButtonTap is available under the MIT license. See the LICENSE file for more info.
