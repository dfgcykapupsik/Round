//
//  LevelGame.swift
//  Block 8
//
//  Created by Фёдор on 18.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit

struct Levels {
    //var blockType = Array(count:5, repeatedValue:Array(count:25, repeatedValue:Int()))
    var onTypeLevels: Array<[String: Int]> = []
    var onTimeLevels: Array<[Int: Int]> = []
    var onTypeLevels1: Array<[Int]> = []
    //var blockType1:
    
    init() {
        self.createTypeLevels()
    }
    
    mutating func createTypeLevels() {//type //count
        // 0 0 1  0 0 0  0 0 0 //size randtype 3 2;
        // 0 0 0  1 0 0  0 0 0 //size randtype 4 4; 4 3; 3 3; 3 2; 4 2;
        // 0 0 1  1 0 0  0 0 0 //size randtype 3 3; 3 2;
        
        // 0 0 1  1 1 0  0 0 0 //size randtype 4 4; 3 3; 4 3; 5 2; 4 2;
        // 0 0 0  1 1 0  0 0 0 //size randtype 4 4; 4 3; 3 3; 4 2; 5 2;
        // 0 0 0  0 1 0  0 0 0 //size randtype 4 3; 3 3; 4 2; 5 2;
        
        // 0 0 0  0 0 1  0 0 0 //size randtype
        // 0 0 0  0 1 1  0 0 0 //size randtype
        // 0 0 0  1 0 1  0 0 0 //size randtype
        // 0 0 0  1 1 1  0 0 0 //size randtype
        // 0 0 1  0 1 1  0 0 0 //size randtype
        
        self.onTypeLevels.append(["randType":1, "size":4,                                    "3":1])
        self.onTypeLevels.append(["randType":1, "size":4,                             "4":1, "3":1])
        self.onTypeLevels.append(["randType":1, "size":4,                             "4":1])
        self.onTypeLevels.append(["randType":2, "size":4,                      "5":1       ])
        self.onTypeLevels.append(["randType":2, "size":4,                      "5":1, "4":1])
        self.onTypeLevels.append(["randType":2, "size":4,                      "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":31, "size":4,               "6":1              ])
        self.onTypeLevels.append(["randType":31, "size":4,               "6":1, "5":1       ])
        self.onTypeLevels.append(["randType":31, "size":4,               "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":42, "size":4,        "7":1              ])
        self.onTypeLevels.append(["randType":42, "size":4,        "7":1, "6":1              ])
        self.onTypeLevels.append(["randType":42, "size":4,        "7":1, "6":1, "5":1       ])
        
        self.onTypeLevels.append(["randType":1, "size":5,                                    "3":1])
        self.onTypeLevels.append(["randType":1, "size":5,                             "4":1, "3":1])
        self.onTypeLevels.append(["randType":1, "size":5,                             "4":1])
        self.onTypeLevels.append(["randType":2, "size":5,                      "5":1       ])
        self.onTypeLevels.append(["randType":2, "size":5,                      "5":1, "4":1])
        self.onTypeLevels.append(["randType":2, "size":5,                      "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":31, "size":5,               "6":1              ])
        self.onTypeLevels.append(["randType":31, "size":5,               "6":1, "5":1       ])
        self.onTypeLevels.append(["randType":31, "size":5,               "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":42, "size":5,        "7":1              ])
        self.onTypeLevels.append(["randType":42, "size":5,        "7":1, "6":1              ])
        self.onTypeLevels.append(["randType":42, "size":5,        "7":1, "6":1, "5":1       ])
        
        self.onTypeLevels.append(["randType":1, "size":4,                                    "3":1])
        self.onTypeLevels.append(["randType":2, "size":4,                             "4":1, "3":1])
        self.onTypeLevels.append(["randType":2, "size":4,                             "4":1])
        self.onTypeLevels.append(["randType":31, "size":4,                      "5":1       ])
        self.onTypeLevels.append(["randType":31, "size":4,                      "5":1, "4":1])
        self.onTypeLevels.append(["randType":31, "size":4,                      "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":42, "size":4,               "6":1              ])
        self.onTypeLevels.append(["randType":42, "size":4,               "6":1, "5":1       ])
        self.onTypeLevels.append(["randType":42, "size":4,               "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":51, "size":4,        "7":1              ])
        self.onTypeLevels.append(["randType":51, "size":4,        "7":1, "6":1              ])
        self.onTypeLevels.append(["randType":51, "size":4,        "7":1, "6":1, "5":1       ])
        //self.onTypeLevels.append(["randType":61, "size":4,        "8":1              ])
        //self.onTypeLevels.append(["randType":61, "size":4,        "8":1, "7":1              ])
        //self.onTypeLevels.append(["randType":61, "size":4,        "8":1, "7":1, "6":1       ])
        
        self.onTypeLevels.append(["randType":1, "size":3,                                    "3":1])
        self.onTypeLevels.append(["randType":2, "size":3,                             "4":1, "3":1])
        self.onTypeLevels.append(["randType":2, "size":3,                             "4":1])
        self.onTypeLevels.append(["randType":31, "size":3,                      "5":1       ])
        self.onTypeLevels.append(["randType":31, "size":3,                      "5":1, "4":1])
        self.onTypeLevels.append(["randType":31, "size":3,                      "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":42, "size":3,               "6":1              ])
        self.onTypeLevels.append(["randType":42, "size":3,               "6":1, "5":1       ])
        self.onTypeLevels.append(["randType":42, "size":3,               "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":51, "size":3,        "7":1              ])
        self.onTypeLevels.append(["randType":51, "size":3,        "7":1, "6":1              ])
        self.onTypeLevels.append(["randType":51, "size":3,        "7":1, "6":1, "5":1       ])
        //self.onTypeLevels.append(["randType":61, "size":3,        "8":1              ])
        //self.onTypeLevels.append(["randType":61, "size":3,        "8":1, "7":1              ])
        //self.onTypeLevels.append(["randType":61, "size":3,        "8":1, "7":1, "6":1       ])
        //self.onTypeLevels.append(["randType":3, "size":4, "9":1              ])
        //self.onTypeLevels.append(["randType":3, "size":4, "9":1, "8":1              ])
        //self.onTypeLevels.append(["randType":3, "size":4, "9":1, "8":1, "7":1       ])
        
        
        
        //self.onTypeLevels.append(["randType":2, "size":3,                             "3":1]) //1
        self.onTypeLevels.append(["randType":2, "size":4,                      "4":1])
        self.onTypeLevels.append(["randType":32, "size":4,                      "4":1])
        self.onTypeLevels.append(["randType":42, "size":4,                      "4":1])//1
        //self.onTypeLevels.append(["randType":4, "size":4,               "5":1       ]) //2
        
        
        self.onTypeLevels.append(["randType":32, "size":3,                      "4":1, "3":1]) //2
        self.onTypeLevels.append(["randType":32, "size":3,                      "4":1]) //1
        self.onTypeLevels.append(["randType":2, "size":4,                      "4":1]) //1
        self.onTypeLevels.append(["randType":2, "size":3,                      "4":1, "3":1]) //2
        
        self.onTypeLevels.append(["randType":42, "size":4,               "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":32, "size":4,               "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":2, "size":5,               "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":2, "size":4,               "5":1, "4":1, "3":1])
        self.onTypeLevels.append(["randType":32, "size":3,               "5":1, "4":1, "3":1]) //2-3
        
        self.onTypeLevels.append(["randType":42, "size":4,               "5":1, "4":1])
        self.onTypeLevels.append(["randType":32, "size":4,               "5":1, "4":1])
        self.onTypeLevels.append(["randType":32, "size":3,               "5":1, "4":1])
        self.onTypeLevels.append(["randType":2, "size":4,               "5":1, "4":1])
        self.onTypeLevels.append(["randType":2, "size":5,               "5":1, "4":1])
        
        
        
        
        
        self.onTypeLevels.append(["randType":3, "size":4,               "5":1, "4":1, "3":1]) //2
        
        self.onTypeLevels.append(["randType":3, "size":4,        "6":1,        "4":1, "3":1])
        self.onTypeLevels.append(["randType":3, "size":4,        "6":1, "5":1,        "3":1])
        self.onTypeLevels.append(["randType":3, "size":4,        "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":3, "size":5,        "6":1, "5":1, "4":1])
        self.onTypeLevels.append(["randType":3, "size":5, "7":1,        "5":1, "4":1])
        
        self.onTypeLevels.append(["randType":3, "size":4,               "5":1       ]) //2
        self.onTypeLevels.append(["randType":4, "size":4,        "6":1              ]) //2-3
        self.onTypeLevels.append(["randType":3, "size":4,        "6":1, "5":1       ]) //2-3
        
        self.onTypeLevels.append(["randType":3, "size":4,        "6":1              ]) //2
        
        self.onTypeLevels.append(["randType":3, "size":3,               "5":1       ]) //3
        self.onTypeLevels.append(["randType":3, "size":3,               "5":1, "4":1]) //3
        
        self.onTypeLevels.append(["randType":4, "size":4,        "6":1, "5":1       ]) //3
        self.onTypeLevels.append(["randType":4, "size":4, "7":1                     ]) //4
        
        
        self.onTypeLevels.append(["randType":3, "size":3,        "6":1              ])
        self.onTypeLevels.append(["randType":3, "size":3,        "6":1, "5":1,      ])
        self.onTypeLevels.append(["randType":3, "size":4, "7":1                     ]) //5
        self.onTypeLevels.append(["randType":3, "size":4, "7":1, "6":1,             ])
        self.onTypeLevels.append(["randType":4, "size":4, "7":1, "6":1,             ]) //5
    }
    
    func createTimeLevels() {
        
    }
    
    func getCountTask(level: Int) -> Int {
        return self.onTypeLevels[level].count - 2
    }
}

class LevelGame: GameModel {
    
    var currentLevel: Int = 0
    
    let levels: Levels = Levels()
    
    //var playingSize = 0
    
    var randomType = 0
    
    override init() {
        //let defaults = NSUserDefaults.standardUserDefaults()
        if let level = NSUserDefaults.standardUserDefaults().integerForKey("level") as? Int {
            self.currentLevel = level
            print("get current level ", level)
        }
        else {
            self.currentLevel = 0
            print("first get current level ")
        }
        currentLevel = 0
        super.init()
    }

    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveLevel() {
        NSUserDefaults.standardUserDefaults().setInteger(currentLevel, forKey: "level")
        print("save level ", currentLevel)
    }
    
    func setLevelSettings(level level: Int) {
        currentLevel = level
        playingSize = levels.onTypeLevels[currentLevel]["size"]!
        randomType = levels.onTypeLevels[currentLevel]["randType"]!
    }
    
    func setLevelSettings() {
        playingSize = levels.onTypeLevels[currentLevel]["size"]!
        randomType = levels.onTypeLevels[currentLevel]["randType"]!
    }
    
    
    override func startGame() {
        resetGame()
        randStartBlock()
        randNextType()
        
    }
    
    func checkProgress() -> Bool {
        var completed = false
        //for i in 2..<self.levels.onTypeLevels[currentLevel].count {
            //print("i ", i)
        //print("current level " , currentLevel)
            for type in 1...9 {
                var countType = 0
                //print("type", type)
                //print("self.levels.onTypeLevels[currentLevel][String(type)] ", self.levels.onTypeLevels[currentLevel][String(type)])
                if (self.levels.onTypeLevels[currentLevel][String(type)] != nil) {
                    for x in 0..<playingSize  {
                        for y in 0..<playingSize  {
                            if blockType[x][y] == type {
                                countType++
                            }
                        }
                    }
                    //print("type ", type)
                    if (countType >= self.levels.onTypeLevels[currentLevel][String(type)]) {
                        completed = true
                        //print("completed true")
                    }
                    else {
                        //print("completed false")
                        completed = false
                        break
                    }
                }
            }
        //}
        return completed
    }
    
    func getPlayingSize() -> Int {
        return playingSize
    }
    
    func nextLevel() {
        currentLevel++
        self.saveLevel()
        playingSize = levels.onTypeLevels[currentLevel]["size"]!
        randomType = levels.onTypeLevels[currentLevel]["randType"]!
        self.startGame()
    }
    func restartLevel() {
        self.startGame()
    }
    
    override func randNextType() { //рандом следующего элемента
        //10%
        //20% -0.26 0.26
        //31% -0.4 0.4
        //40% -0.53 0.53
        //51% -0.69 0.69
        //60% -0.85 0.85
        //68.2% -1 1
        //70% -1.05 1.05
        //80% -1.3 1.3
        //85,3% -1.45 1.45
        //90% -1.65 1.65
        //93% -1.8 1.8
        //95,45% -2 2
        //100%
        let r = Random()
        
        let x = r.randomGaussian()
        //x = x * 3.333
        //print("rand x")
        //print(x)
        if (randomType == 1) {
            if (fabs(x) >= 0 && fabs(x) <= 3) {
                //print("if 1")
                typeNextBlock = 1
            }
        }
        
        if (randomType == 2) { //60 100
            if (fabs(x) >= 0 && fabs(x) <= 0.85) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.85 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 2
            }
        }
        
        if (randomType == 31) { //31 70 100
            if (fabs(x) >= 0 && fabs(x) <= 0.4) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.4 && fabs(x) <= 1.05) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 1.05 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 3
            }
        }
        
        if (randomType == 32) { //20 80 100
            if (fabs(x) >= 0 && fabs(x) <= 0.26) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.85) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.85 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 3
            }
        }
        
        if (randomType == 41) { //21 40 70 100
            if (fabs(x) >= 0 && fabs(x) <= 0.26) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.53) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.53 && fabs(x) <= 1.05) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 1.05 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 4
            }
        }
        
        if (randomType == 42) { //21 50 80 100
            if (fabs(x) >= 0 && fabs(x) <= 0.26) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.69) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.69 && fabs(x) <= 1.3) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 1.3 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 4
            }
        }
        
        if (randomType == 51) { // ?? 20 50 80 100
            if (fabs(x) >= 0 && fabs(x) <= 0.13) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.13 && fabs(x) <= 0.26) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.69) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 0.69 && fabs(x) <= 1.3) {
                //print("if 3")
                typeNextBlock = 4
            }
            if (fabs(x) > 1.3 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 5
            }
        }
        
        if (randomType == 52) { // 20 40 60 80 100
            if (fabs(x) >= 0 && fabs(x) <= 0.26) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.53) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.53 && fabs(x) <= 0.85) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 0.85 && fabs(x) <= 1.3) {
                //print("if 3")
                typeNextBlock = 4
            }
            if (fabs(x) > 1.3 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 5
            }
        }
        
        if (randomType == 61) { //20 40 60 80 93 100 // срднее 3.07
            if (fabs(x) >= 0 && fabs(x) <= 0.26) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.26 && fabs(x) <= 0.53) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.53 && fabs(x) <= 0.85) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 0.85 && fabs(x) <= 1.3) {
                //print("if 3")
                typeNextBlock = 4
            }
            if (fabs(x) > 1.3 && fabs(x) <= 1.8) {
                //print("if 3")
                typeNextBlock = 5
            }
            if (fabs(x) > 1.8 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 6
            }
        }
        
        if (randomType == 62) { // <20 30 50 70 85 100 //среднее 3.5
            if (fabs(x) >= 0 && fabs(x) <= 0.1) {
                //print("if 1")
                typeNextBlock = 1
            }
            if (fabs(x) > 0.1 && fabs(x) <= 0.4) {
                //print("if 2")
                typeNextBlock = 2
            }
            if (fabs(x) > 0.4 && fabs(x) <= 0.69) {
                //print("if 3")
                typeNextBlock = 3
            }
            if (fabs(x) > 0.69 && fabs(x) <= 1.05) {
                //print("if 3")
                typeNextBlock = 4
            }
            if (fabs(x) > 1.05 && fabs(x) <= 1.45) {
                //print("if 3")
                typeNextBlock = 5
            }
            if (fabs(x) > 1.45 && fabs(x) <= 3) {
                //print("if 3")
                typeNextBlock = 6
            }
        }
    }
    
    private func randStartBlock() {//рандом начальных условий
        
        var maxRandType: UInt32 = 0
        //_: UInt32 = 0
        
        if (randomType == 1) {
            maxRandType = 0
        }
        if (randomType == 2) {
            maxRandType = 1
        }
        if (randomType == 31 || randomType == 32) {
            maxRandType = 2
        }
        if (randomType == 41 || randomType == 42) {
            maxRandType = 3
        }
        if (randomType == 6) {
            maxRandType = 5
        }
        let i = 3 + Int(arc4random_uniform(2))
        for var j = 0; j < i; j++ {
            
            let x = Int(arc4random_uniform(UInt32(playingSize)))
            let y = Int(arc4random_uniform(UInt32(playingSize)))
            //let type = 1 + Int(arc4random_uniform(5))
            let type = 1 + Int(arc4random_uniform(maxRandType))
            self.setStartType(x, y: y, type: type)
        }
        
        //print("countFilled Rand")
        //print(countFilledBlock)
    }
    
    func getCurrentLevel() -> Int {
        return currentLevel
    }
}