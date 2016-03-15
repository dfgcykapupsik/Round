//
//  SettingsViewController.swift
//  Block 8
//
//  Created by Фёдор on 26.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    //var buttonBack = UIButton() as UIButton
    
    var buttonSound = TextButton()
    var buttonLetters = TextButton()
    var buttonBack = TextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewdidload")
        self.createButton()
        self.buttonSound.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.buttonLetters.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.buttonBack.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        
        buttonSound.on = Settings.sound
        
        buttonSound.turn()
        buttonLetters.on = Settings.lettersOnRect
        
        buttonLetters.turn()
        buttonBack.switchButton = false
    }
    
    override func viewDidAppear(animated: Bool) {
        self.onScreen(true)
        print("viewDidAppear")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func createButton() {
        //print("Setting sound", Settings.sound)
        buttonSound = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, numberButton: 1)
        buttonSound.label.text = "Sound"
        buttonSound.callback = {
            Settings.sound = self.buttonSound.on
            //print("Setting sound", Settings.sound)
        }
        self.view.addSubview(buttonSound)
        
        buttonLetters = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, numberButton: 2)
        buttonLetters.label.text = "Letters"
        buttonLetters.callback = {
            Settings.lettersOnRect = self.buttonLetters.on
            //print("Setting sound", Settings.sound)
        }
        self.view.addSubview(buttonLetters)
        
        buttonBack = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, numberButton: 3)
        
        buttonBack.label.text = "Back"
        buttonBack.callback = {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        self.view.addSubview(buttonBack)
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    private func onScreen(on: Bool) {
        if on {
            self.buttonSound.animateButton(onScreen: true, wait: 0.1, duration: 0.1)
            self.buttonLetters.animateButton(onScreen: true, wait: 0.1, duration: 0.1)
            self.buttonBack.animateButton(onScreen: true, wait: 0.1, duration: 0.1)
        }
        else {
            self.buttonSound.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonLetters.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonBack.animateButton(onScreen: false , wait: 0.0, duration: 0.1)
        }
    }
    
    func createSwitch() {
        
        let switchSound = UISwitch(frame:CGRectMake(150, 300, 0, 0))
        switchSound.on = Settings.sound
        //switchSound.frame.width
        //switchDemo.setOn(true, animated: false)
        switchSound.addTarget(self, action: "switchValueSound:", forControlEvents: .ValueChanged)
        self.view.addSubview(switchSound)
        
        let switchLetters = UISwitch(frame:CGRectMake(150, 400, 0, 0))
        switchLetters.on = Settings.lettersOnRect
        //switchDemo.setOn(true, animated: false)
        switchLetters.addTarget(self, action: "switchValueLetters:", forControlEvents: .ValueChanged)
        self.view.addSubview(switchLetters)
    }
    
    func switchValueSound(sender:UISwitch!)
    {
        if (sender.on == true) {
            Settings.sound = true
        }
        else {
            Settings.sound = false
        }
    }
    
    func switchValueLetters(sender:UISwitch!)
    {
        if (sender.on == true) {
            Settings.lettersOnRect = true
        }
        else {
            Settings.lettersOnRect = false
        }
    }
    
    func buttonBack(sender:UIButton!)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
}