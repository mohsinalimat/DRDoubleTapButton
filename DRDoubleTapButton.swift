//
//  DRDoubleTapButton.swift
//  DRDoubleTapButton
//
//  Created by Diego Rueda on 17/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

import UIKit

class DRDoubleTapButton: UIView {
    let primaryButton   = UIButton()
    let confirmButton   = UIButton()
    let label           = UILabel()

    var buttonTitleColor   = UIColor.whiteColor()
    var buttonWidth: CGFloat = 200.0
    var buttonHeight: CGFloat = 44.0
    var buttonVerticalSlide: CGFloat = -22.0
    var buttonHorizontalSlide: CGFloat = -100.0
    var buttonSlidesHorizontally = true
    var buttonOriginalCenter: CGPoint!
    
    var primaryButtonTitle      = "Press Me"
    var primaryButtonBgColor    = UIColor.blueColor()
    var primaryButtonReactsToTap = false
    var buttonAnimationDuration = 0.5
    
    var confirmButtonTitle      = "Confirm"
    var confirmButtonBgColor    = UIColor.redColor()
    
    var labelSuccessText    = "OK!"
    var labelSuccessColor   = UIColor.greenColor()
    var labelErrorText      = "Error. Try again."
    var labelErrorColor     = UIColor.redColor()

    required init(coder aDecoder: NSCoder) {
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
        /// MARK: Setting label properties
        label.text = labelSuccessText
        label.textAlignment = .Center
        label.backgroundColor = labelSuccessColor
        addSubview(label)
        
        /// MARK: Setting buttons properties
        buttonVerticalSlide = -(buttonHeight / 2)
        buttonHorizontalSlide = -(buttonWidth / 2)
        
        confirmButton.setTitle(confirmButtonTitle, forState: .Normal)
        confirmButton.backgroundColor = confirmButtonBgColor
        addSubview(confirmButton)
        
        primaryButton.setTitle(primaryButtonTitle, forState: .Normal)
        primaryButton.backgroundColor = primaryButtonBgColor
        addSubview(primaryButton)
        
        /// MARK: Setting actions for buttons
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
    override func layoutSubviews() {
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
