//
//  ScoreView.swift
//  Block 8
//
//  Created by Фёдор on 25.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class ScoreView: UIView {
    
    var callback: (() -> ())?
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var taskWidth: CGFloat = 0
    var taskHeight: CGFloat = 0
    
    var textLabelWidth: CGFloat = 0
    var textLabelHeight: CGFloat = 0
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var taskLabelWidth: CGFloat = 0
    
    var squareWidth: CGFloat = 0
    let blockDistance: CGFloat = 2
    
    let textLabel = UILabel()
    let scoreLabel = UILabel()
    
    var iphone4s = false
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        
        if (UIDevice.currentDevice().modelName == "iPhone 4s") {
            iphone4s = true
        }
        //self.taskWidth = 70
        //self.taskHeight = 37 * 2
        
        if iphone4s {
            self.taskHeight = ((self.screenHeight - self.screenWidth) / 2 - 34 - 0 * self.taskHeight) * 0.8
            self.taskWidth = self.taskHeight * 70 / 74 * 4
            
            self.taskHeight = round(taskHeight)
            self.taskWidth = round(taskWidth)
            self.textLabelWidth = round(taskWidth / 2)
            self.textLabelHeight = round(taskHeight)
            
            self.x = (self.screenWidth - taskWidth) / 2
            self.y = 34 + ((self.screenHeight - self.screenWidth) / 2 - 34 - self.taskHeight) / 2
        }
        else {
            self.taskHeight = ((self.screenHeight - self.screenWidth) / 2 - 34 - 0 * self.taskHeight) * 0.8
            self.taskWidth = self.taskHeight * 70 / 74
            
            self.taskHeight = round(taskHeight)
            self.taskWidth = round(taskWidth)
            self.textLabelWidth = round(taskWidth)
            self.textLabelHeight = round(taskHeight / 2)
            
            self.x = (self.screenWidth - taskWidth) / 2
            self.y = 34 + ((self.screenHeight - self.screenWidth) / 2 - 34 - self.taskHeight) / 2
        }
        
        
        
        print("x ", x)
        print("y ", y)
        print("taskWidth ", taskWidth)
        print("taskHeight ", taskHeight)
        
        super.init(frame: CGRect(x: x, y: y/*0.1 * screenHeight*/, width: self.taskWidth, height: self.taskHeight))
        self.backgroundColor = UIColor.redColor()
        self.createLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func createLabel() {
        
        //textLabel.frame = CGRectMake(0, -1, taskLabelWidth + 1, taskHeight + 1)
        if iphone4s {
            textLabel.frame = CGRectMake(0, 0, taskWidth / 2, taskHeight)
            textLabel.font = UIFont (name: "Ostrich Sans", size: 30)
        }
        else {
            textLabel.frame = CGRectMake(0, 0, taskWidth , taskHeight / 2)
            textLabel.font = UIFont (name: "Ostrich Sans", size: 33)
        }
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = "score"
        //textLabel.backgroundColor = UIColor.blueColor()
        textLabel.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(textLabel)
        
        if iphone4s {
            scoreLabel.frame = CGRectMake(taskWidth / 2, 0, taskWidth / 2, taskHeight)
            scoreLabel.font = UIFont (name: "Ostrich Sans", size: 30)
        }
        else {
            scoreLabel.frame = CGRectMake(0, taskHeight / 2, taskWidth + 2, taskHeight / 2 + 1)
            scoreLabel.font = UIFont (name: "Ostrich Sans", size: 30)
        }
        //scoreLabel.frame = CGRectMake(taskLabelWidth + 1, -1, taskWidth - taskLabelWidth + 10, taskHeight + 1)
        scoreLabel.textColor = UIColor.blackColor()
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.text = "0"
       // scoreLabel.backgroundColor = UIColor.greenColor()
        scoreLabel.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(scoreLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        callback!()
    }
    
    func animateScore(pause pause: Bool, wait: Double, duration: Double) {
        if pause {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x - self.screenWidth
                }, completion: {finished in
                    ///self.score.hidden = true
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x
                }, completion: {finished in
                    ///self.score.hidden = true
            })
        }
    }
}