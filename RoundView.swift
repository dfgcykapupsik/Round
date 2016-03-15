//
//  RoundView.swift
//  Round
//
//  Created by Фёдор on 29.02.16.
//  Copyright © 2016 Fiodar. All rights reserved.
//

import Foundation
import UIKit

class RoundView: UIView {
    
    var callback: (() -> Void)?
    var location: CGPoint
    var type: Int
    var diametr: CGFloat
    var radiusInnerCircle: CGFloat
    
    var textSize: CGFloat = 30
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    var buttonWidth: CGFloat = 0
    var buttonHeight: CGFloat = 0
    
    let blockDistance: CGFloat = 2
    
    let inCircle = UIView()
    let outCircle = UIView()
    let letterLabel = UILabel()
    
    init(diametr: CGFloat) {
        self.diametr = diametr
        self.buttonWidth = diametr
        self.buttonHeight = diametr
        self.radiusInnerCircle = diametr / 2  - self.screenWidth * 0.01
        callback = {}
        type = 0
        location = CGPoint(x: 0,y: 0)
        super.init(frame: CGRectZero)
        //self.backgroundColor = UIColor.orangeColor()
        self.createLabel()
        self.createCircles()
    }
    
    init(i: CGFloat, j: CGFloat, diametr: CGFloat) {
        self.buttonWidth = diametr
        self.buttonHeight = diametr
        self.diametr = diametr
        callback = {}
        type = 0
        location = CGPoint(x: i,y: j)
        self.radiusInnerCircle = diametr / 2  - self.screenWidth * 0.018
        
        super.init(frame: CGRect(x: x, y: y, width: self.buttonWidth, height: self.buttonHeight))
        
        self.createLabel()
        self.createCircles()
    }
    
    required init(coder aDecoder: NSCoder) {
        callback = {}
        type = 0
        location = CGPoint(x: 0,y: 0)
        diametr = 0
        
        self.radiusInnerCircle = diametr / 2  - self.screenWidth * 0.018
        super.init(coder: aDecoder)!
    }
    
    private func createLabel() {
        
        letterLabel.frame = CGRectMake(2 + diametr / 2 - radiusInnerCircle, diametr / 2 - radiusInnerCircle, radiusInnerCircle * 2 - 2, radiusInnerCircle * 2)
        letterLabel.textAlignment = NSTextAlignment.Center
        letterLabel.textColor = UIColor.whiteColor()
        letterLabel.text = ""
        letterLabel.font = UIFont (name: "Ostrich Sans", size: 30)
        letterLabel.numberOfLines = 0
    }
    
    private func createCircles() {
        
        outCircle.frame = CGRectMake(0, 0, buttonWidth, buttonHeight)
        outCircle.backgroundColor = UIColor.whiteColor()
        outCircle.layer.cornerRadius = buttonWidth / 2
        
        inCircle.frame = CGRectMake(diametr / 2 - radiusInnerCircle, diametr / 2 - radiusInnerCircle, radiusInnerCircle * 2, radiusInnerCircle * 2)
        inCircle.backgroundColor = UIColor.whiteColor()
        inCircle.layer.cornerRadius = radiusInnerCircle
        
        outCircle.addSubview(inCircle)
        outCircle.addSubview(letterLabel)
        self.addSubview(outCircle)
        
    }
    
    func animateButton(onScreen onScreen: Bool, wait: Double, duration: Double) {
        if onScreen {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x
                }, completion: {finished in
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.frame.origin.x = self.x - self.screenWidth
                }, completion: {finished in
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        callback!()
    }
}