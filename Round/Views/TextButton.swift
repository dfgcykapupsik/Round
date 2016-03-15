//
//  TextButton.swift
//  Block 8
//
//  Created by Фёдор on 15.02.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class TextButton: UIView {
    
    var callback: (() -> Void)?
    
    var textSize: CGFloat = 30
    
    var numberButton = -1
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var buttonWidth: CGFloat = 0
    var buttonHeight: CGFloat = 0
    
    var label = UILabel()
    
    var on = true
    
    var switchButton = true
    var grayButton = false
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat, numberButton: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.x = 0
        self.y = 0
        print("x ",x)
        print("y ",y)
        
        self.numberButton = Int(numberButton)
        switch numberButton {
        case 0:
            self.buttonHeight = ((self.screenHeight - self.screenWidth) / 2 - 34) * 0.8
            self.buttonWidth = self.screenWidth * 0.4
            self.x = 10
            self.y = 34 + ((self.screenHeight - self.screenWidth) / 2 - 34 - self.buttonHeight) / 2
        case 1:
            self.buttonWidth = screenWidth
            self.buttonHeight = screenHeight / 5
            self.x = 0
            self.y = (self.screenHeight - 3 * self.buttonHeight) / 4 * 1
        case 2:
            self.buttonWidth = screenWidth
            self.buttonHeight = screenHeight / 5
            self.x = 0
            self.y = (self.screenHeight - 3 * self.buttonHeight) / 4 * 2 + self.buttonHeight
        case 3:
            self.buttonWidth = screenWidth
            self.buttonHeight = screenHeight / 5
            self.x = 0
            self.y = (self.screenHeight - 3 * self.buttonHeight) / 4 * 3 + self.buttonHeight * 2
        default:
            self.buttonWidth = screenHeight / 2
            self.buttonHeight = screenHeight / 2
        }
        
        
        super.init(frame: CGRect(x: 0, y: y, width: self.buttonWidth, height: self.buttonHeight))
        self.createButton()
        self.turn()
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    init(x: CGFloat, y: CGFloat, buttonWidth: CGFloat, buttonHeight: CGFloat) {
        self.x = x
        self.y = y
        
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        
        
        super.init(frame: CGRect(x: 0, y: y, width: self.buttonWidth, height: self.buttonHeight))
        self.createButton()
        self.turn()
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat, left: Bool) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        self.switchButton = false
        self.grayButton = true
        self.numberButton = 0
        if left {
            self.buttonWidth = screenWidth / 2
            self.buttonHeight = screenHeight / 5
            self.x = 0
            self.y = self.screenHeight * 39 / 50
        }
        else {
            self.buttonWidth = screenWidth / 2
            self.buttonHeight = screenHeight / 5
            self.x = screenWidth / 2
            self.y = self.screenHeight * 39 / 50
        }
        
        super.init(frame: CGRect(x: x, y: y, width: self.buttonWidth, height: self.buttonHeight))
        self.createButton()
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat, center: Bool) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        self.switchButton = false
        self.grayButton = true
        self.numberButton = 0
        
        self.buttonWidth = screenWidth 
        self.buttonHeight = screenHeight / 5
        self.x = 0
        self.y = self.screenHeight * 39 / 50
        
        super.init(frame: CGRect(x: x, y: y, width: self.buttonWidth, height: self.buttonHeight))
        self.createButton()
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func turn() {
        if (switchButton) {
            if on {
                label.textColor = UIColor.getSquareColor(5)
            }
            else {
                label.textColor = UIColor.getButtonColor()
            }
        }
    }
    
    private func createButton() {
        label = UILabel(frame: CGRectMake(0, 0, buttonWidth, buttonHeight))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        //label.backgroundColor = UIColor.redColor()
        //label.text = ""
        if grayButton {
            label.textColor = UIColor.getButtonColor()
        }
        else {
            label.textColor = UIColor.getSquareColor(5)
        }
        
        if (numberButton == 0) {
            label.font = UIFont (name: "Ostrich Sans", size: screenHeight / 1.62 / 1.62 * 0.2)
        }
        else {
            label.font = UIFont (name: "Ostrich Sans", size: 70)
        }
        
        self.addSubview(label)
        
    }
    
    func animateButton(onScreen onScreen: Bool, wait: Double, duration: Double) {
        if onScreen {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x
                }, completion: {finished in
                    ///self.score.hidden = true
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x - self.screenWidth
                }, completion: {finished in
                    ///self.score.hidden = true
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.on = !self.on
        self.turn()
        callback!()
    }
}