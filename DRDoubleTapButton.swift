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
    /// Corner Radius of the entire component. Default to empty (no radius)
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Border Width of the entire component. Default to empty (no border)
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Border Color of the entire component. Default to empty (no color)
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(CGColor: layer.borderColor)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
    
/// MARK: Common Buttons properties
    /// Button Vertical Slide. Computed property to move the button vertically outside the frame
    var buttonVerticalSlide: CGFloat {
            return -buttonHeight / 2
    }
    /// Button Horizontal Slide. Computed property to move the button horizontally outside the frame
    var buttonHorizontalSlide: CGFloat {
            return -buttonWidth / 2
    }
    
    /// Button Original Center. To return to its original position after slide the button
    var buttonOriginalCenter: CGPoint!
    
    /// Button Width. Default to 200
    @IBInspectable var buttonWidth: CGFloat = 200.0
    
    /// Button Height. Default to 44
    @IBInspectable var buttonHeight: CGFloat = 44.0
    
    /// Controls the sliding direction for the buttons. If true, buttons slide horizontal; if false, buttons slides vertical. Default: slideds horizontally
    @IBInspectable var buttonSlidesHorizontally: Bool = true

    /// NSTimeInterval duration of the buttons slide animation
    @IBInspectable var buttonAnimationDuration: NSTimeInterval = 0.5
    
/// MARK: Primary Button properties
    /// Controls if the primary button works reacts to a single tap or to pan gesture. Default: only reacts to pan gesture
    @IBInspectable var primaryButtonReactsToTap: Bool = false
    
    /// Text for the primary button. Be sure that it fits the button. Default to empty string
    @IBInspectable var primaryButtonTitle: String = "" {
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
    
/// MARK: Label properties
    /// Text for label when confirm button returns a success message. Defatul to "SUCCESS"
    @IBInspectable var labelSuccessText: String = "SUCCESS" {
        didSet {
            label.text = labelSuccessText
        }
    }
    
    /// Text color for label when confirm button returns a success message. Default to green
    @IBInspectable var labelSuccessTextColor: UIColor? = UIColor.greenColor() {
        didSet {
            label.textColor = labelSuccessTextColor
        }
    }
    
    /// Background color for label when confirm button returns a success message. Default to white
    @IBInspectable var labelSuccessBgColor: UIColor? = UIColor.whiteColor() {
        didSet {
            label.backgroundColor = labelSuccessBgColor
        }
    }
    
    /// Text for label when confirm button returns an error message. Defatul to "ERROR"
    @IBInspectable var labelErrorText: String = "ERROR"
    
    /// Text color for label when confirm button returns an error message. Default to red
    @IBInspectable var labelErrorTextColor: UIColor? = UIColor.redColor()
    
    /// Background color for label when confirm button returns an error message. Default to white
    @IBInspectable var labelErrorBgColor: UIColor? = UIColor.redColor()

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
/// MARK: Setting up label properties
        label.text = labelSuccessText
        label.textColor = labelSuccessTextColor
        label.textAlignment = .Center
        label.backgroundColor = labelSuccessBgColor
        addSubview(label)
        
/// MARK: Setting up buttons properties
        confirmButton.setTitle(confirmButtonTitle, forState: .Normal)
        confirmButton.backgroundColor = confirmButtonBgColor
        addSubview(confirmButton)
        
        primaryButton.setTitle(primaryButtonTitle, forState: .Normal)
        primaryButton.backgroundColor = primaryButtonBgColor
        addSubview(primaryButton)
        
        /// MARK: Setting up actions for buttons
        if primaryButtonReactsToTap {
            primaryButton.addTarget(self, action: "primaryTap:", forControlEvents: .TouchDown)
        }
        else {
            /// Adding pan gesture to primary button
            let panReconigzer = UIPanGestureRecognizer(target: self, action: "primaryHandlePan:")
            panReconigzer.maximumNumberOfTouches = 1
            primaryButton.addGestureRecognizer(panReconigzer)
        }
        
        confirmButton.addTarget(self, action: "confirmTap:", forControlEvents: .TouchDown)
    }
    
    /// Called when the system wants update a layout
    override public func layoutSubviews() {
        let width   = bounds.size.width
        let height  = bounds.size.height
        
        primaryButton.frame = CGRect(x: 0, y: 0, width: self.buttonWidth, height: self.buttonHeight)
        buttonOriginalCenter = primaryButton.center
        
        confirmButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
/// MARK: Button actions handlers
    @IBAction func primaryTap(sender: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            if self.buttonSlidesHorizontally {
                self.primaryButton.center.x = self.buttonHorizontalSlide
            }
            else {
                self.primaryButton.center.y = self.buttonVerticalSlide
            }
        })
    }
    
    @IBAction func primaryHandlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Changed:
            var translation = gesture.translationInView(primaryButton)

            if buttonSlidesHorizontally {
                let minXTranslation = buttonOriginalCenter.x - buttonWidth
                let maxXTranslation = buttonOriginalCenter.x + buttonWidth
                primaryButton.center.x = max(minXTranslation, min(maxXTranslation, primaryButton.center.x + translation.x))
            }
            else {
                let minYTranslation = buttonOriginalCenter.y - buttonHeight
                let maxYTranslation = buttonOriginalCenter.y + buttonHeight
                primaryButton.center.y = max(minYTranslation, min(maxYTranslation, primaryButton.center.y + translation.y))
            }
            gesture.setTranslation(CGPointZero, inView: primaryButton)
            
        case .Ended:
            if primaryButton.center.x <= 0 || primaryButton.center.y <= 0 {
                primaryTap(primaryButton)
            }
            else {
                slideButtonToOriginalPosition()
            }
        default: break
        }
    }
    
    @IBAction func confirmTap(sender: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            if self.buttonSlidesHorizontally {
                self.confirmButton.center.x = self.buttonHorizontalSlide
            }
            else {
                self.confirmButton.center.y = self.buttonVerticalSlide
            }
        })
    }
    
    func slideButtonToOriginalPosition() {
        if primaryButton.center != buttonOriginalCenter {
            UIView.animateWithDuration(buttonAnimationDuration) {
                self.primaryButton.center = self.buttonOriginalCenter
            }
        }
    }
}
