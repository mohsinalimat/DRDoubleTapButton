//
//  ViewController.swift
//  DoubleTapButton
//
//  Created by Diego Rueda on 17/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deleteButton: DoubleTapButton!
    @IBOutlet weak var redButton: DoubleTapButton!
    @IBOutlet weak var makeButton: DoubleTapButton!
    
    func redButtonPushed() -> Bool {
        /// Do something and then return boolean
        return false
    }
    
    func deleteButtonPushed() -> Bool {
        /// Do something and then return boolean
        return true
    }
    
    func makeButtonPushed() -> Bool {
        /// Do something and then return boolean
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Assign functions to each button
        redButton.functionToCall = redButtonPushed
        deleteButton.functionToCall = deleteButtonPushed
        makeButton.functionToCall = makeButtonPushed
    }
}

