//
//  NextRectView.swift
//  Block 8
//
//  Created by Фёдор on 25.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class NextRectView: UIView {
    
    var callback: (() -> ())?
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var taskWidth: CGFloat = 0
    var taskHeight: CGFloat = 0
    
    var squareWidth: CGFloat = 0
    let blockDistance: CGFloat = 2
    
    let textLabel = UILabel()
    let rect = UIView()
    let letterLabel = UILabel()
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        self.squareWidth = (screenWidth - 4 * blockDistance) / 5 / 2
        
        
        self.taskHeight = 20
        self.taskWidth = screenWidth * 0.9
        self.x = 0.05 * screenWidth
        self.y = 14
        
        super.init(frame: CGRect(x: x, y: y, width: self.taskWidth, height: self.taskHeight))
        
        self.createLabel()
        self.createRect()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func createLabel() {
        textLabel.frame = CGRectMake(10, 1, taskWidth - 20 , taskHeight)
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = NSTextAlignment.Left
        
        textLabel.text = "NEXT"
        textLabel.font = UIFont (name: "Ostrich Sans", size: 18)
        rect.addSubview(textLabel)
        
        
        letterLabel.frame = CGRectMake(taskWidth / 2, 1, taskWidth / 2 - 10, taskHeight)
        letterLabel.textAlignment = NSTextAlignment.Right
        letterLabel.textColor = UIColor.whiteColor()
        letterLabel.numberOfLines = 0
        letterLabel.text = ""
        letterLabel.font = UIFont (name: "Ostrich Sans", size: 18)
    }
    
    private func createRect() {
        
        rect.frame = CGRectMake(0, 0, taskWidth, taskHeight)
        rect.backgroundColor = UIColor.greenColor()
        rect.addSubview(letterLabel)
        rect.layer.cornerRadius = taskHeight / 2
        
        self.addSubview(rect)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        callback!()
    }
    
    func animateNext(pause pause: Bool, wait: Double, duration: Double) {
        if pause {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.y = self.y - 40
                }, completion: {finished in
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.y = self.y
                }, completion: {finished in
            })
        }
    }
}