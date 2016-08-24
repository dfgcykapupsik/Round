//
//  CircleButton.swift
//  Block 8
//
//  Created by Фёдор on 04.02.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class CircleButton: UIView {
    
    var callback: (() -> Void)?
    
    var textSize: CGFloat = 30
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var buttonWidth: CGFloat = 0
    var buttonHeight: CGFloat = 0
    
    var squareWidth: CGFloat = 0
    let blockDistance: CGFloat = 2
    
    let inCircle = UIView()
    let outCircle = UIView()
    let letterLabel = UILabel()
    var circleRadiusDifference: CGFloat = 0
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    init(x: CGFloat, y: CGFloat, screenWidth: CGFloat, screenHeight: CGFloat, typeButton: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.x = x
        self.y = y
        print("x ",x)
        print("y ",y)
        self.squareWidth = (screenWidth - 4 * blockDistance) / 5 / 2
        
        /*switch typeButton {
        case 1:
            self.buttonWidth = screenWidth / 2
            self.buttonHeight = screenWidth / 2
        case 2:
            self.buttonWidth = screenWidth * 0.5 / 1.62
            self.buttonHeight = screenWidth * 0.5 / 1.62
        case 3:
            self.buttonWidth = screenWidth * 0.2
            self.buttonHeight = screenWidth * 0.2
        default:
            self.buttonWidth = screenWidth / 2
            self.buttonHeight = screenWidth / 2
        }*/
        /*switch typeButton {
        case 1:
            self.buttonWidth = screenWidth / 1.62
            self.buttonHeight = screenWidth / 1.62
        case 2:
            self.buttonWidth = screenWidth / 1.62 / 1.62
            self.buttonHeight = screenWidth / 1.62 / 1.62
        case 3:
            self.buttonWidth = screenWidth / 1.62 / 1.62 / 1.62
            self.buttonHeight = screenWidth / 1.62 / 1.62 / 1.62
        default:
            self.buttonWidth = screenWidth / 2
            self.buttonHeight = screenWidth / 2
        }*/
        
        switch typeButton {
        case 1:
            self.buttonWidth = screenHeight / 1.62 / 1.62
            self.buttonHeight = screenHeight / 1.62 / 1.62
        case 2:
            self.buttonWidth = screenHeight / 1.62 / 1.62 / 1.62
            self.buttonHeight = screenHeight / 1.62 / 1.62 / 1.62
        case 3:
            self.buttonWidth = screenHeight / 1.62 / 1.62 / 1.62 / 1.62
            self.buttonHeight = screenHeight / 1.62 / 1.62 / 1.62 / 1.62
        case 12:
            self.buttonWidth = 25
            self.buttonHeight = 25
        default:
            self.buttonWidth = screenHeight / 2
            self.buttonHeight = screenHeight / 2
        }
        
        circleRadiusDifference = 0.01 * self.screenWidth
        
        super.init(frame: CGRect(x: x, y: y, width: self.buttonWidth, height: self.buttonHeight))
        
        self.createLabel()
        self.createCircles()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func createLabel() {
        
        letterLabel.frame = CGRectMake(circleRadiusDifference, circleRadiusDifference + buttonHeight * 0.05, buttonWidth - circleRadiusDifference * 2, buttonHeight - circleRadiusDifference * 2 - buttonHeight * 0.05)
        letterLabel.textAlignment = NSTextAlignment.Center
        letterLabel.textColor = UIColor.whiteColor()
        //letterLabel.backgroundColor = UIColor.redColor()
        letterLabel.text = ""
        letterLabel.font = UIFont (name: "Ostrich Sans", size: buttonWidth * 0.28)
        //letterLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: buttonWidth * 0.2)
    }
    
    private func createCircles() {
        
        outCircle.frame = CGRectMake(0, 0, buttonWidth, buttonHeight)
        //rect.backgroundColor = UIColor.greenColor()
        outCircle.backgroundColor = UIColor.whiteColor()
        outCircle.layer.cornerRadius = buttonWidth / 2
        
        inCircle.frame = CGRectMake(circleRadiusDifference, circleRadiusDifference, buttonWidth - circleRadiusDifference * 2, buttonHeight - circleRadiusDifference * 2)
        //rect.backgroundColor = UIColor.greenColor()
        inCircle.backgroundColor = UIColor.whiteColor()
        inCircle.layer.cornerRadius = buttonWidth / 2 - circleRadiusDifference
        
        outCircle.addSubview(inCircle)
        outCircle.addSubview(letterLabel)
        self.addSubview(outCircle)
        
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
    
    /*func animateDisappearanceButton(onScreen onScreen: Bool, wait: Double, duration: Double) {
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
    }*/
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        callback!()
    }
}