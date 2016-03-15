//
//  Extensions .swift
//  Block 8
//
//  Created by Фёдор on 25.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension String {
    static func getLetter(type: Int) -> String {
        switch (type) {
        case 0:
            return ""
            
        case 1:
            return "a"
        case 2:
            return "b"
        case 3:
            return "c"
            
        case 4:
            return "d"
        case 5:
            return "e"
        case 6:
            return "f"
            
        case 7:
            return "g"
        case 8:
            return "h"
        case 9:
            return "i"
            
        default:
            return ""
        }
    }
}

extension UIColor {
    
    class func getButtonColor() -> UIColor {
        return UIColor.getColorRGB(red: 222, green: 222, blue: 222)
    }
    
    class func getSquareColor(type: Int) -> UIColor {
        switch (type) {
        case 0:
            return UIColor.getColorRGB(red: 244, green: 244, blue: 244)
            //return UIColor.whiteColor()
        case 1:
            return UIColor.getColorRGB(red: 159, green: 62, blue: 213)
        case 2:
            return UIColor.getColorRGB(red: 103, green: 73, blue: 215)
        case 3:
            return UIColor.getColorRGB(red: 51, green: 204, blue: 204)
            
        case 4:
            return UIColor.getColorRGB(red: 57, green: 230, blue: 57)
        case 5:
            return UIColor.getColorRGB(red: 182, green: 246, blue: 62)
        case 6:
            return UIColor.getColorRGB(red: 255, green: 228, blue: 64)
            
        case 7:
            return UIColor.getColorRGB(red: 255, green: 191, blue: 64)
        case 8:
            return UIColor.getColorRGB(red: 255, green: 69, blue: 64)
        case 9:
            return UIColor.getColorRGB(red: 212, green: 53, blue: 205)
            
        default:
            return UIColor.whiteColor()
        }
        
    }
    
    class func getRingColor(type: Int) -> UIColor {
        switch (type) {
        case 0:
            return UIColor.getLightColorRGB(red: 244, green: 244, blue: 244)
            
        case 1:
            return UIColor.getLightColorRGB(red: 159, green: 62, blue: 213)
        case 2:
            return UIColor.getLightColorRGB(red: 103, green: 73, blue: 215)
        case 3:
            return UIColor.getLightColorRGB(red: 51, green: 204, blue: 204)
            
        case 4:
            return UIColor.getLightColorRGB(red: 57, green: 230, blue: 57)
        case 5:
            return UIColor.getLightColorRGB(red: 182, green: 246, blue: 62)
        case 6:
            return UIColor.getLightColorRGB(red: 255, green: 228, blue: 64)
            
        case 7:
            return UIColor.getLightColorRGB(red: 255, green: 191, blue: 64)
        case 8:
            return UIColor.getLightColorRGB(red: 255, green: 69, blue: 64)
        case 9:
            return UIColor.getLightColorRGB(red: 212, green: 53, blue: 205)
            
        default:
            return UIColor.whiteColor()
        }
        
    }
    
    class func getColorRGB(red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    class func getLightColorRGB(red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 0.7)
    }
    /*case 0:
    return UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1)
    case 1:
    return UIColor(red: 255.0 / 255.0, green: 248.0 / 255.0, blue: 115.0 / 255.0, alpha: 1)
    case 2:
    return UIColor(red: 255.0 / 255.0, green: 242.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
    case 3:
    return UIColor(red: 166.0 / 255.0, green: 157.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
    case 4:
    return UIColor(red: 215.0 / 255.0, green: 249 / 255.0, blue: 112.0 / 255.0, alpha: 1)
    case 5:
    return UIColor(red: 183 / 255.0, green: 242 / 255.0, blue: 0.0 / 255.0, alpha: 1)
    case 6:
    return UIColor(red: 119 / 255.0, green: 158 / 255.0, blue: 0.0 / 255.0, alpha: 1)*/
}

extension CGRect {
    
    static func getPauseSquare(ii: CGFloat, jj: CGFloat, type: Int, blockDistance: CGFloat, squareWidth: CGFloat, sx: CGFloat, degreeIncrease: CGFloat) -> CGRect {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let sizeDifference = CGFloat.getSizeDifference(type, squareWidth: squareWidth)
        
        return CGRectMake(blockDistance + degreeIncrease * (jj * (squareWidth + blockDistance)) + sizeDifference / 1 - sx, ((screenHeight - screenWidth) / 2 + degreeIncrease * (squareWidth + blockDistance) * ii) - sx + sizeDifference / 1, degreeIncrease * (squareWidth - sizeDifference), degreeIncrease * (squareWidth - sizeDifference))
        
    }
    static func getSquare(ii: CGFloat, jj: CGFloat, type: Int, blockDistance: CGFloat, squareWidth: CGFloat) -> CGRect {
        //squareWidth = (screenWidth - CGFloat(sayPlayingSize - 1) * blockDistance) / CGFloat(sayPlayingSize)
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let sizeDifference = CGFloat.getSizeDifference(type, squareWidth: squareWidth)
        
        //print("x")
        //print(blockDistance + (jj * (squareWidth + blockDistance) + sizeDifference / 2))
        //print("y")
        //print(((screenHeight - screenWidth) / 2 +  (squareWidth + blockDistance) * ii + sizeDifference / 2))
        
        return CGRectMake(blockDistance + (jj * (squareWidth + blockDistance) + sizeDifference / 2), ((screenHeight - screenWidth) / 2 +  (squareWidth + blockDistance) * ii + sizeDifference / 2), squareWidth - sizeDifference, squareWidth - sizeDifference)
        
    }
    static func getNextSquare(type: Int, blockDistance: CGFloat, squareWidth: CGFloat) -> CGRect {
        _ = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let sizeDifference = CGFloat.getSizeDifference(type, squareWidth: squareWidth)
        
        return CGRectMake(20 + sizeDifference / 2, 0.1 * screenHeight + sizeDifference / 2, squareWidth - sizeDifference, squareWidth - sizeDifference)
        
    }
    
    static func getPositionSquare(ii: CGFloat, jj: CGFloat, blockDistance: CGFloat, diametr: CGFloat) -> CGRect {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        //return CGPoint
        // print("blockDistance")
        //print(blockDistance)
        
        // print("squareWidth")
        //print(squareWidth)
        // print("blockDistance + (jj * (squareWidth + blockDistance)) + squareWidth / 2")
        //print(blockDistance + (jj * (squareWidth + blockDistance)) + squareWidth / 2)
        return CGRectMake(3 * blockDistance + (jj * (diametr + blockDistance)),
            (screenHeight - screenWidth) / 2 +  (diametr + blockDistance) * ii, diametr, diametr)
    }
}

extension CGPoint {
    static func getPositionSquare(ii: CGFloat, jj: CGFloat, blockDistance: CGFloat, diametr: CGFloat) -> CGPoint {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        //return CGPoint
       // print("blockDistance")
        //print(blockDistance)
        
       // print("squareWidth")
        //print(squareWidth)
       // print("blockDistance + (jj * (squareWidth + blockDistance)) + squareWidth / 2")
        //print(blockDistance + (jj * (squareWidth + blockDistance)) + squareWidth / 2)
        return CGPointMake(3 * blockDistance + (jj * (diametr + blockDistance)) + diametr / 2, (screenHeight - screenWidth) / 2 +  (diametr + blockDistance) * ii + diametr / 2)
    }
    
    static func getScoreNodePosition(pause pause:Bool) -> CGPoint {
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        if pause {
            return CGPointMake(screenWidth / 2, screenHeight / 2 + screenHeight / 8 )
        }
        return CGPointMake(screenWidth / 2 + screenWidth, screenHeight / 2 + screenHeight / 8 )
        
    }
    
    static func getButtonNodePosition(pause pause:Bool, number: Int) -> CGPoint {
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        if pause {
            switch (number) {
            case 1:
                return CGPointMake(screenWidth / 2 - screenWidth / 3, screenHeight / 2 - screenHeight / 8)
            case 2:
                return CGPointMake(screenWidth / 2, screenHeight / 2 - screenHeight / 6)
            case 3:
                return CGPointMake(screenWidth / 2 + screenWidth / 3, screenHeight / 2 - screenHeight / 8)
            default:
                return CGPointMake(screenWidth / 2, screenHeight / 2 - screenHeight / 6)
            }
        }
        switch (number) {
        case 1:
            return CGPointMake(screenWidth / 2 - screenWidth / 4 + screenWidth, screenHeight / 2 - screenHeight / 6)
        case 2:
            return CGPointMake(screenWidth / 2 + screenWidth, screenHeight / 2 - screenHeight / 6)
        case 3:
            return CGPointMake(screenWidth / 2 + screenWidth / 4 + screenWidth, screenHeight / 2 - screenHeight / 6)
        default:
            return CGPointMake(screenWidth / 2 + screenWidth, screenHeight / 2 - screenHeight / 6)
        }
        
    }
}

extension CGSize {
    
    
    static func getSquareSize(type: Int, squareWidth: CGFloat) -> CGSize {
        var size = CGSize(width: 0,height: 0)
        switch (type) {
        case -1:
            size.height = 0
            size.width = 0
            
        case 0:
            size.height = squareWidth - 14
            size.width = squareWidth - 14
            
        case 1,2,3:
            size.height = squareWidth - 14
            size.width = squareWidth - 14
            
        case 4,5,6:
            size.height = squareWidth - 8
            size.width = squareWidth - 8
            
        case 7,8,9:
            size.height = squareWidth
            size.width = squareWidth
            
        default:
            size.height = 0
            size.width = 0
        }
        return size
    }
}

extension CGFloat {
    static func getScale(type: Int, squareWidth: CGFloat) -> CGFloat {
        var scale: CGFloat = 0
        switch (type) {
        case -1:
            scale = 0
            
        case 0:
            scale = 2 / squareWidth
            
        case 1,2,3:
            scale = (squareWidth - 14) / squareWidth
            
        case 4,5,6:
            scale = (squareWidth - 8) / squareWidth
            
        case 7,8,9:
            scale = squareWidth / squareWidth
            
        default:
            scale = squareWidth / squareWidth
        }
        return scale
    }
    
    static func getSizeDifference(type: Int, squareWidth: CGFloat) -> CGFloat {
        //map
        var sizeDifference: CGFloat = 0
        switch (type) {
        case -1:
            sizeDifference = squareWidth
            
        case 0:
            sizeDifference = squareWidth - 2
            
        case 1:
            sizeDifference = 14
        case 2:
            sizeDifference = 14
        case 3:
            sizeDifference = 14
            
        case 4:
            sizeDifference = 8
        case 5:
            sizeDifference = 8
        case 6:
            sizeDifference = 8
            
        case 7:
            sizeDifference = 0
        case 8:
            sizeDifference = 0
        case 9:
            sizeDifference = 0
            
        default:
            sizeDifference = 0
        }
        return sizeDifference
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}