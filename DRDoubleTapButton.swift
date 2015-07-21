//
//  DRDoubleTapButton.swift
//  DRDoubleTapButton
//
//  Created by Diego Rueda on 17/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

import UIKit

@IBDesignable
public class DRDoubleTapButton: UIView {
    /// Elements
    let primaryButton   = UIButton()
    let confirmButton   = UIButton()
    let label           = UILabel()
    
/// MARK: frame properties
    /// Corner Radius of the frame. Default to empty (no radius)
    @IBInspectable var borderRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Border Width of the frame. Default to empty (no border)
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Border Color of the frame. Default to empty (no color)
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(CGColor: layer.borderColor)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    
/// MARK: Common Buttons properties
    /// Button Horizontal Slide. Computed property to move the button horizontally outside the frame
    var buttonHorizontalSlide: CGFloat {
        return -bounds.size.width / 2
    }

    /// Button Vertical Slide. Computed property to move the button vertically outside the frame
    var buttonVerticalSlide: CGFloat {
        return -bounds.size.height / 2
    }
    
    /// Button Original Center. To return to its original position after slide the button
    var buttonOriginalCenter: CGPoint!
    
    /// Controls the sliding direction for the buttons. If true, buttons slide horizontal; if false, buttons slides vertical. Default: slideds horizontally
    @IBInspectable var buttonSlidesHorizontally: Bool = true

    /// NSTimeInterval duration of the buttons slide animation
    @IBInspectable var buttonAnimationDuration: NSTimeInterval = 0.5
    
/// MARK: Primary Button properties
    /// Controls if the primary button works reacts to a single tap or to pan gesture. Default: only reacts to pan gesture
    @IBInspectable var reactsToTap: Bool = false
    
    /// Text for the primary button. Be sure that it fits the button. Default to "DO SOMETHING AMAZING"
    @IBInspectable var primaryButtonTitle: String = "DO SOMETHING AMAZING" {
        didSet {
            primaryButton.setTitle(primaryButtonTitle, forState: .Normal)
        }
    }
    
    /// Text color for the primary button. Be sure that it's different than primaryButtonBgColor to make it readable
    @IBInspectable var primaryButtonTitleColor: UIColor? = UIColor.whiteColor() {
        didSet {
            primaryButton.setTitleColor(primaryButtonTitleColor, forState: .Normal)
        }
    }
    
    /// Background color for the primary button. Be sure that it's different than primaryButtonTitleColor to make it readable
    @IBInspectable var primaryButtonBgColor: UIColor? = UIColor.whiteColor() {
        didSet {
            primaryButton.backgroundColor = primaryButtonBgColor
        }
    }
    
    @IBInspectable var bgImageName: String = "" {
        didSet {
            let bgImage = UIImage(named: bgImageName)
            primaryButton.setBackgroundImage(bgImage, forState: .Normal)
        }
    }
    
/// MARK: Confirm Button properties
    ///
    /// Text for the confirm button. Be sure that it fits the button. Default to "CONFIRM"
    @IBInspectable var confirmButtonTitle: String = "CONFIRM" {
        didSet {
            confirmButton.setTitle(confirmButtonTitle, forState: .Normal)
        }
    }
    
    /// Text color for the confirm button. Be sure that it's different than confirmButtonBgColor to make it readable
    @IBInspectable var confirmButtonTitleColor: UIColor = UIColor.whiteColor() {
        didSet {
            confirmButton.setTitleColor(confirmButtonTitleColor, forState: .Normal)
        }
    }

    /// Background color for the confirm button. Be sure that it's different than confirmButtonTitleColor to make it readable
    @IBInspectable var confirmButtonBgColor: UIColor = UIColor.whiteColor() {
        didSet {
            confirmButton.backgroundColor = confirmButtonBgColor
        }
    }
    
/// MARK: Function to call in confirm button
    /// Function that the confirm button calls. You must to define it in code (IBInspectable doesn't accept function type) It must be a reference to a function wich returns a boolean, but you can change the implementation. Just be sure to change it also in confirmTap() when it is used. Default to (() -> true)
    var functionToCall: () -> Bool = { return false }
    
/// MARK: Label properties
    /// Text for label when confirm button returns a success message. Defatul to "SUCCESS"
    @IBInspectable var labelSuccessText: String = "SUCCESS"
    
    /// Text color for label when confirm button returns a success message. Default to green
    @IBInspectable var labelSuccessTextColor: UIColor? = UIColor.greenColor()
    
    /// Background color for label when confirm button returns a success message. Default to white
    @IBInspectable var labelSuccessBgColor: UIColor? = UIColor.whiteColor()
    
    /// Text for label when confirm button returns an error message. Default to "ERROR"
    @IBInspectable var labelErrorText: String = "ERROR"
    
    /// Text color for label when confirm button returns an error message. Default to red
    @IBInspectable var labelErrorTextColor: UIColor? = UIColor.redColor()
    
    /// Background color for label when confirm button returns an error message. Default to white
    @IBInspectable var labelErrorBgColor: UIColor? = UIColor.whiteColor()

/// MARK: Initialization
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Users can use both init functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// Initialize the component
    func setup() {
        
        self.clipsToBounds = true
        
        /// Setting up label properties
        label.text = labelSuccessText
        label.textColor = labelSuccessTextColor
        label.textAlignment = .Center
        label.backgroundColor = labelSuccessBgColor
        addSubview(label)
        
        /// Setting up buttons properties
        confirmButton.setTitle(confirmButtonTitle, forState: .Normal)
        confirmButton.backgroundColor = confirmButtonBgColor
        addSubview(confirmButton)
        
        primaryButton.setTitle(primaryButtonTitle, forState: .Normal)
        primaryButton.backgroundColor = primaryButtonBgColor
        addSubview(primaryButton)
    }
    
    /// Called when the system wants update a layout
    override public func layoutSubviews() {
        let width = bounds.size.width
        let height = bounds.size.height

        primaryButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        buttonOriginalCenter = primaryButton.center
        
        confirmButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        /// Setting up actions for buttons
        if reactsToTap {
            primaryButton.addTarget(self, action: "slideButtonOutOfFrame:", forControlEvents: .TouchDown)
        }
        else {
            /// Adding pan gesture to primary button
            let panReconigzer = UIPanGestureRecognizer(target: self, action: "primaryHandlePan:")
            panReconigzer.maximumNumberOfTouches = 1
            primaryButton.addGestureRecognizer(panReconigzer)
        }
        
        confirmButton.addTarget(self, action: "confirmTap:", forControlEvents: .TouchDown)
    }
    
/// MARK: Button actions handlers
    /// Pan gesture of primary button. When user slide the button beyond the center of the component, it slides out the frame
    @IBAction func primaryHandlePan(gesture: UIPanGestureRecognizer) {
        let width = bounds.size.width
        let height = bounds.size.height
        
        switch gesture.state {
        case .Changed:
            var translation = gesture.translationInView(primaryButton)

            if buttonSlidesHorizontally {
                let minXTranslation = buttonOriginalCenter.x - width
                let maxXTranslation = buttonOriginalCenter.x + width
                primaryButton.center.x = max(minXTranslation, min(maxXTranslation, primaryButton.center.x + translation.x))
            }
            else {
                let minYTranslation = buttonOriginalCenter.y - height
                let maxYTranslation = buttonOriginalCenter.y + height
                primaryButton.center.y = max(minYTranslation, min(maxYTranslation, primaryButton.center.y + translation.y))
            }
            gesture.setTranslation(CGPointZero, inView: primaryButton)
            
        case .Ended:
            if primaryButton.center.x <= 0 || primaryButton.center.y <= 0 {
                slideButtonOutOfFrame(primaryButton)
            }
            else {
                slideButtonToOriginalPosition(primaryButton)
            }
        default: break
        }
    }
    
    /// Tap in the confirm button. Calls to functionToCall to manage the response
    @IBAction func confirmTap(sender: UIButton) {
        if functionToCall() {
            label.text = labelSuccessText
            label.textColor = labelSuccessTextColor
            label.backgroundColor = labelSuccessBgColor
            
            slideButtonOutOfFrame(confirmButton)
        }
        else {
            label.text = labelErrorText
            label.textColor = labelErrorTextColor
            label.backgroundColor = labelErrorBgColor
            
            slideButtonOutOfFrame(confirmButton)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.slideButtonToOriginalPosition(self.primaryButton)
                self.slideButtonToOriginalPosition(self.confirmButton)
            }
        }
    }
    
    /// Slides button out of the frame if the user slide it beyond the center of the component or if he taps in the primary button when primaryButtonReactsToTap is true
    func slideButtonOutOfFrame(button: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            if self.buttonSlidesHorizontally {
                button.center.x = self.buttonHorizontalSlide
            }
            else {
                button.center.y = self.buttonVerticalSlide
            }
        })
    }
    
    /// Returns button to its original position when user doesn't slide it beyond the center of the component
    func slideButtonToOriginalPosition(button: UIButton) {
        if button.center != buttonOriginalCenter {
            UIView.animateWithDuration(buttonAnimationDuration) {
                button.center = self.buttonOriginalCenter
            }
        }
    }
}