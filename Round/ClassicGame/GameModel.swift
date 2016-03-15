//
//  Game.swift
//  Block 06
//
//  Created by Fedor on 26.11.15.
//  Copyright © 2015 dfgckpsk. All rights reserved.
//

import Foundation
import UIKit



class GameModel: NSObject, NSCoding {
    
    var coorBlock: Array<Int> = []
    
    var playingSize = 5
    
    var blockRepeat = Array(count:5, repeatedValue:Array(count:5, repeatedValue:Bool())) //при обходе чекает где уже был
    var blockType = Array(count:5, repeatedValue:Array(count:5, repeatedValue:Int())) //типы блоков в точках
    
    var countFilledBlock: Int
    var score: Int
    var typeNextBlock: Int
    
    
    override init() {
        countFilledBlock = 0
        score = 0
        typeNextBlock = 1
        for var i = 0; i < playingSize; i++ {
            for var j = 0; j < playingSize; j++ {
                blockType[i][j] = 0
            }
        }
    }
    
    init(countFilledBlock: Int, score: Int, typeNextBlock: Int, blockType: Array<[Int]>) {
        self.countFilledBlock = countFilledBlock
        self.score = score
        self.typeNextBlock = typeNextBlock
        self.blockType = blockType
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let countFilledBlock = aDecoder.decodeIntegerForKey("countFilledBlock")
        let score = aDecoder.decodeIntegerForKey("score")
        let typeNextBlock = aDecoder.decodeIntegerForKey("typeNextBlock")
        let blockType = aDecoder.decodeObjectForKey("blockType") as! Array<[Int]>
        self.init(countFilledBlock: countFilledBlock, score: score, typeNextBlock: typeNextBlock, blockType: blockType)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(countFilledBlock, forKey: "countFilledBlock")
        aCoder.encodeInteger(score, forKey: "score")
        aCoder.encodeInteger(typeNextBlock, forKey: "typeNextBlock")
        aCoder.encodeObject(blockType, forKey: "blockType")
    }
    
    func startGame() {
        resetGame()
        randStartBlock()
        randNextType()
    }
    
    func randNextType() { //рандом следующего квадрата
        
        let r = Random()
        
        let x = r.randomGaussian()
        //print("rand x")
        //print(x)
        
        /*if (fabs(x) >= 0 && fabs(x) <= 0.45) {
            //print("if 1")
            typeNextBlock = 1
        }
        if (fabs(x) > 0.45 && fabs(x) <= 0.7) {
            //print("if 2")
            typeNextBlock = 2
        }
        if (fabs(x) > 0.7 && fabs(x) <= 1.4) {
            //print("if 3")
            typeNextBlock = 3
        }
        if (fabs(x) > 1.4 && fabs(x) <= 1.8) {
            //print("if 3")
            typeNextBlock = 4
        }
        if (fabs(x) > 1.8 && fabs(x) <= 2) {
            //print("if 3")
            typeNextBlock = 5
        }
        if (fabs(x) > 2 && fabs(x) <= 3) {
            //print("if 3")
            typeNextBlock = 6
        }*/
        
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
    
    private func randStartBlock() {//рандом начальных условий
        
        let i = 3 + Int(arc4random_uniform(2))
        for var j = 0; j < i; j++ {
            
            let x = Int(arc4random_uniform(UInt32(playingSize)))
            let y = Int(arc4random_uniform(UInt32(playingSize)))
            //let type = 1 + Int(arc4random_uniform(5))
            let type = 1 + Int(arc4random_uniform(2))
            self.setStartType(x, y: y, type: type)
        }
        
        //print("countFilled Rand")
        //print(countFilledBlock)
    }
    
    func clickButton(x: Int, y: Int, type: Int, fromAnalyze: Bool) { //функция вызываемая при клике на квадрат
        if (getType(x, y: y) == 0 || fromAnalyze == true) {
            if (type == 0) {
                self.setType(x,y: y,type: type)
                return
            }
            
            self.setType(x,y: y,type: type)
            self.checkAround(x, y: y, type: type)
            self.clearBlockRepeat()
            //lastTransitionCoordinate = coorBlock
            self.analyzeStack(type)
            self.printBlockType()
            self.randNextType()
            print("countFilledBlock")
            print(countFilledBlock)
        }
    }
    
    func empty(x: CGFloat, y: CGFloat) -> Bool {
        if (blockType[Int(x)][Int(y)] == 0) {
            //print("empty")
            return true
        }
        //print("!empty x ", x, " y ", y, " blockType ", blockType[Int(x)][Int(y)])
        return false
    }
    
    func setStartType(x: Int, y: Int, type: Int) {
        if (blockType[x][y] == 0) {
            blockType[x][y] = type;
            countFilledBlock++
        }
    }
    
    func setType(x: Int, y: Int, type: Int) {
        if (blockType[x][y] == 0) {
            blockType[x][y] = type;
        }
    }
    
    private func addScore(type: Int, countBlock: Int) { //подсчет очков
        //print("scoreType")
        //print(score)
        //print(type)
        switch type {
        case 1:
            score = score + 1 * countBlock
        case 2:
            score = score + 2 * countBlock
        case 3:
            score = score + 3 * countBlock
        case 4:
            score = score + 6 * countBlock
        case 5:
            score = score + 8 * countBlock
        case 6:
            score = score + 12 * countBlock
        case 7:
            score = score + 20 * countBlock
        case 8:
            score = score + 40 * countBlock
        case 9:
            score = score + 100 * countBlock
        default:
            score = score + 0
        }
    }
    
    func checkAround(x: Int, y: Int, type: Int) { //пробег по квадратам в поисках таких же
        blockRepeat[x][y] = true;
        //coorBlock.push(x)
        //coorBlock.push(y)
        coorBlock.append(x)
        coorBlock.append(y)
        //left
        if (x > 0) {
            if (checkBlockType(x - 1, y: y, type: type) && blockRepeat[x - 1][y] == false) {
                checkAround(x - 1, y: y , type: type)
            }
            
        }
        
        //right
        if (x < playingSize - 1) {
            if (checkBlockType(x + 1, y: y, type: type) && blockRepeat[x + 1][y] == false) {
                checkAround(x + 1, y: y , type: type)
            }
            
        }
        
        //down
        if (y > 0) {
            if (checkBlockType(x, y: y - 1, type: type) && blockRepeat[x][y - 1] == false) {
                checkAround(x, y: y - 1, type: type)
            }
            
        }
        
        //up
        if (y < playingSize - 1) {
            if (checkBlockType(x, y: y + 1, type: type) && blockRepeat[x][y + 1] == false) {
                checkAround(x, y: y + 1, type: type)
            }
            
        }
    }
    
    /*func getLastTransition() -> Array<Int> {
        return lastTransitionCoordinate
    }*/
    
    func analyzeStack(type: Int) {//аналих результатов пробега по квадратам
        let t = coorBlock.count
        print("t ", t)
        
        //print("countFilled1")
        //print(countFilledBlock)
        if (t / 2 >= 3) {
            addScore(type, countBlock: coorBlock.count / 2)
            for var i = 0; i < t/2 - 1; i++ {
                //let y = coorBlock.pop()
                //let x = coorBlock.pop()
                let y = coorBlock.removeLast()
                let x = coorBlock.removeLast()
                blockType[x][y] = 0
                countFilledBlock--
                //print("countFilled for if1")
                //print(countFilledBlock)
            }
            //let y = coorBlock.pop()
            //let x = coorBlock.pop()
            let y = coorBlock.removeLast()
            let x = coorBlock.removeLast()
            if (type >= 9) {
                blockType[x][y] = 0
                //print("countFilled if 1")
                //print(countFilledBlock)
                clickButton(x, y: y, type: 0, fromAnalyze: true)
            }
            else {
                blockType[x][y] = type + 1
                //print("countFilled if 1")
                //print(countFilledBlock)
                clickButton(x, y: y, type: type + 1, fromAnalyze: true)
            }
        }
        if (t / 2 < 3) {
            //let y = coorBlock.pop()
            //let x = coorBlock.pop()
            let y = coorBlock.removeLast()
            let x = coorBlock.removeLast()
            blockType[x][y] = type
            countFilledBlock++
            //print("countFilled if 2")
            //print(countFilledBlock)
            
        }
        //coorBlock.clear()
        coorBlock.removeAll()
        //print("countFilled end")
        //print(countFilledBlock)
    }
    
    func checkBlockType(x: Int, y: Int, type: Int) -> Bool { //есть ли в данной точке куб данного типа
        if (blockType[x][y] == type) {
            return true
        }
        return false
    }
    
    func getType(x: Int, y: Int) -> Int {
        return blockType[x][y]
    }
    
    func getNextType() -> Int{
        return typeNextBlock
    }
    
    func getScore() -> String {
        return String(score)
    }
    
    func getScoreInt() -> Int {
        return score
    }
    
    func getCountFilledBlock() -> Int {
        return countFilledBlock
    }
    
    private func clearBlockRepeat() {
        for var i = 0; i < playingSize; i++ {
            for var j = 0; j < playingSize; j++ {
                blockRepeat[i][j] = false;
            }
        }
    }
    
    func resetGame() {
        score = 0
        countFilledBlock = 0
        for var i = 0; i < playingSize; i++ {
            for var j = 0; j < playingSize; j++ {
                blockType[i][j] = 0
            }
        }
    }
    
    private func printBlockType() {
       // print("printTypes")
        for var i = 0; i < playingSize; i++ {
          //  print(String(blockType[i][0]) + " " + String(blockType[i][1]) + " " + String(blockType[i][2]) + " " + String(blockType[i][3]) + " " + String(blockType[i][4]) + " " + String(blockType[i][5]))
        }
    }
    
    func saveResult() {
        var saveResult : Array<Int> = []
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("result") != nil) {
            saveResult = (defaults.objectForKey("result") as? Array<Int>)!
        }
        var result : Array<Int> = []
        for var i = 0; i < saveResult.count; i++ {
            result.insert(saveResult[i], atIndex: i)
        }
        for var i = saveResult.count; i < 10; i++ {
            result.insert(0, atIndex: i)
        }
        result.insert(self.getScoreInt(), atIndex: 10)
        result.sortInPlace{return $0 > $1}
        result.removeLast()
        NSUserDefaults.standardUserDefaults().setObject(result, forKey: "result")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
