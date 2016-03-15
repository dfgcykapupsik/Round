//
//  Settings.swift
//  Block 8
//
//  Created by Фёдор on 26.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation

class Settings {
    
    init() {
        self.createSettings()
    }
    
    private func createSettings() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(true, forKey: "sound")
        defaults.synchronize()
        
        defaults.setBool(true, forKey: "lettersOnRect")
        defaults.synchronize()
        
        defaults.setBool(false, forKey: "firstRun")
        defaults.synchronize()
        print("create settings")
    }
}

extension Settings {
    
    class var sound: Bool {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            print("get letters sound")
            return defaults.boolForKey("sound")
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey: "sound")
            defaults.synchronize()
            print("set letters sound ", newValue)
            
        }
    }
    
    class var lettersOnRect: Bool {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            print("get letters on rect")
            return defaults.boolForKey("lettersOnRect")
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(newValue, forKey: "lettersOnRect")
            defaults.synchronize()
            print("set letters lettersOnRect ", newValue)
            
        }
        
    }
}