//
//  CircleLineView.swift
//  Block 8
//
//  Created by Фёдор on 28.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

class CircleLineView: UIView {
    
    var callback: (() -> ())?
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    var lineWidth: CGFloat = 0
    var lineHeight: CGFloat = 0
    
    var squareWidth: CGFloat = 0
    let blockDistance: CGFloat = 2
    var circleDistance: CGFloat = 0
    
    var circleRadius: CGFloat = 0
    var circles: Array<UIView> = []
    
    let rect = UIView()
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    init(screenWidth: CGFloat, screenHeight: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        self.squareWidth = (screenWidth - 4 * blockDistance) / 5 / 2
        
        //self.lineHeight = squareWidth * 0.5
        self.lineHeight = 20
        self.lineWidth = screenWidth * 0.88
        self.circleRadius = lineHeight / 2
        self.circleDistance = (self.lineWidth - 9 * circleRadius * 2) / 8
        
        //super.init(frame: CGRect(x: 0.7 * screenWidth, y: /*(self.infoHeight - 0.8 * self.infoHeight) / 2*/ 0.1 * screenHeight, width: self.taskWidth, height: self.taskHeight))
        super.init(frame: CGRect(x: 0.06 * screenWidth, y: /*(self.infoHeight - 0.8 * self.infoHeight) / 2*/ /*0.95 * screenHeight*/ screenHeight - 34, width: self.lineWidth, height: self.lineHeight))
        //self.backgroundColor = UIColor.blackColor()
        self.createCircles()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func animateCircles(pause pause: Bool, wait: Double, duration: Double) {
        
        for _ in 0..<self.circles.count {
            //self.circles[circleNumber].frame.origin.y = 1.2 * self.screenHeight
            //print("circleNumber ", circleNumber, "frame", self.circles[circleNumber].frame)
        }
        //print("screenHeight * 0.95 ", 0.95 * screenHeight)
        if pause {
            for circleNumber in 0..<self.circles.count {
                UIView.animateWithDuration(duration, delay: wait + Double(circleNumber) * 0.02, options: .CurveLinear, animations: {
                    //self.circleLine.frame.origin.y = 1.2 * self.screenHeight
                    //self.circles[circleNumber].frame.origin.y = 1.2 * self.screenHeight
                    self.circles[circleNumber].frame.origin.y = 200
                    }, completion: {finished in
                })
            }
        }
        else {
            for circleNumber in 0..<self.circles.count {
                UIView.animateWithDuration(duration, delay: wait + Double(circleNumber) * 0.02, options: .CurveLinear, animations: {
                    //self.circleLine.frame.origin.y = 0.95 * self.screenHeight
                    //self.circles[circleNumber].frame.origin.y = 0.95 * self.screenHeight
                    self.circles[circleNumber].frame.origin.y = 0
                    }, completion: {finished in
                })
            }
        }
        for _ in 0..<self.circles.count {
            //self.circles[circleNumber].frame.origin.y = 1.2 * self.screenHeight
            //print("finish circleNumber ", circleNumber, "frame", self.circles[circleNumber].frame)
        }
    }
    
    private func createCircles() {
        
        for numbCircle in 0...9 {
            let circle = UIView(frame: CGRectMake(0 + CGFloat(numbCircle) * (circleRadius * 2 + circleDistance), 0 , circleRadius * 2, circleRadius * 2))
            circle.layer.cornerRadius = circleRadius
            circle.backgroundColor = UIColor.getSquareColor(numbCircle + 1)
            circles.append(circle)
            self.addSubview(circle)
        }
        //rect.frame = CGRectMake(taskWidth - squareWidth, 0, squareWidth, taskHeight)
        /*rect.frame = CGRectMake(0, 0, taskWidth, squareWidth * 0.5)
        //rect.backgroundColor = UIColor.greenColor()
        rect.backgroundColor = UIColor.whiteColor()
        rect.addSubview(letterLabel)
        rect.layer.cornerRadius = squareWidth * 0.5 / 2*/
        
        //self.addSubview(rect)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        callback!()
    }
}