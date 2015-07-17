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
    var buttonWidth        = 200
    var buttonHeight       = 44
    var buttonSlide: CGFloat = -22
    
    var primaryButtonTitle      = "Press Me"
    var primaryButtonBgColor    = UIColor.blueColor()
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
        /// MARK: Setting buttons properties
        buttonSlide = CGFloat(-(buttonHeight / 2))
        
        primaryButton.setTitle(primaryButtonTitle, forState: .Normal)
        primaryButton.backgroundColor = primaryButtonBgColor
        addSubview(primaryButton)
        
        confirmButton.setTitle(confirmButtonTitle, forState: .Normal)
        confirmButton.backgroundColor = confirmButtonBgColor
        addSubview(confirmButton)

        /// MARK: Setting label properties
        label.text = labelSuccessText
        label.textAlignment = .Center
        label.backgroundColor = labelSuccessColor
        addSubview(label)
        
        /// MARK: Actions for buttons
        primaryButton.addTarget(self, action: "primaryTap:", forControlEvents: .TouchDown)
        confirmButton.addTarget(self, action: "confirmTap:", forControlEvents: .TouchDown)
        
        /// Adding pan gesture to primary button
        let panReconigzer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panReconigzer.maximumNumberOfTouches = 1
        primaryButton.addGestureRecognizer(panReconigzer)
    }
    
    /// Called when the system wants update a layout
    override func layoutSubviews() {
        let width   = bounds.size.width
        let height  = bounds.size.height
        
        primaryButton.frame = CGRect(x: 0, y: 0, width: self.buttonWidth, height: self.buttonHeight)
        confirmButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        confirmButton.hidden = true
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        label.hidden = true
    }
    
    @IBAction func primaryTap(sender: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            self.primaryButton.center.y = self.buttonSlide
            self.confirmButton.hidden = false
        })
    }
    
    @IBAction func handlePan(sender: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            self.primaryButton.center.y = self.buttonSlide
            self.confirmButton.hidden = false
        })
    }
    
    @IBAction func confirmTap(sender: UIButton) {
        UIView.animateWithDuration(buttonAnimationDuration, animations: {
            self.confirmButton.center.y = self.buttonSlide
            self.label.hidden = false
        })
    }
}
