//
//  TaskRectView.swift
//  Block 8
//
//  Created by Фёдор on 25.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class TaskRectView: UIView {
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var taskWidth: CGFloat = 0
    var taskHeight: CGFloat = 0
    var y:CGFloat = 0
    var x:CGFloat = 0
    
    var squareWidth: CGFloat = 0
    let blockDistance: CGFloat = 2
    
    let taskLabel = UILabel()
    let rect = UIView()
    let letterLabel = UILabel()
    
    var roundType:Int? {
        didSet {
            rect.backgroundColor = UIColor.getSquareColor(roundType!)
        }
    }
    var lettersOnRect: Bool? {
        didSet {
            print("var lettersOnRect: Bool? { didSet {")
            self.createLetter()
        }
    }
    
    
    init(screenWidth: CGFloat, screenHeight: CGFloat, numberTask: CGFloat, countTask: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        self.taskHeight = 37
        self.taskWidth = 2 *  self.taskHeight
        
        self.y = ((self.screenHeight - self.screenWidth) / 2 + self.screenWidth) + (self.screenHeight - ((self.screenHeight - self.screenWidth) / 2 + self.screenWidth) - 34 - self.taskHeight) / 2
        self.x = (screenWidth - countTask * taskWidth) / (countTask + 1) * (numberTask) + taskWidth * (numberTask - 1)
        
        super.init(frame: CGRect(x: x,
            y: y, width: self.taskWidth, height: self.taskHeight))
        //self.backgroundColor = UIColor.redColor()
        self.createLabel()
        self.createRect()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func createLabel() {
        
        taskLabel.frame = CGRectMake(taskWidth / 2, 0, taskWidth / 2, taskHeight + 1)
        taskLabel.backgroundColor = UIColor.whiteColor()
        taskLabel.textColor = UIColor.blackColor()
        taskLabel.textAlignment = NSTextAlignment.Center
        taskLabel.text = " x"
        taskLabel.backgroundColor = UIColor.whiteColor()
        taskLabel.font = UIFont (name: "Ostrich Sans", size: 20)
        self.addSubview(taskLabel)
        
        letterLabel.frame = CGRectMake(0, 4, taskWidth / 2, taskHeight - 4)
        letterLabel.textAlignment = NSTextAlignment.Center
        letterLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        letterLabel.textColor = UIColor.whiteColor()
        letterLabel.text = ""
        letterLabel.font = UIFont (name: "Ostrich Sans", size: 20)
    }
    
    private func createRect() {
        
        rect.frame = CGRectMake(0, 0, taskWidth / 2, taskHeight)
        rect.layer.cornerRadius = taskHeight / 2
        self.addSubview(rect)
        rect.addSubview(letterLabel)
    }
    
    private func createLetter() {
        if (lettersOnRect == true) {
            letterLabel.text = String.getLetter(roundType!)
        }
        else {
            letterLabel.text = ""
        }
    }
    
    func animateTask(pause pause: Bool, wait: Double, duration: Double) {
        if pause {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x - self.screenWidth
                }, completion: {finished in
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x
                }, completion: {finished in
            })
        }
    }
}