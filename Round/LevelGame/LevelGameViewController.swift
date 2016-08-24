//
//  LevelGameViewController.swift
//  Block 8
//
//  Created by Фёдор on 25.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AudioToolbox
import iAd
import AVFoundation

class LevelGameViewController: UIViewController, ADInterstitialAdDelegate {
    
    var clickPlayer:AVAudioPlayer = AVAudioPlayer()
    
    let settingsView = SettingsViewController()
    
    var interstitialAd:ADInterstitialAd!
    var interstitialAdView: UIView = UIView()
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let blockDistance: CGFloat = 2
    var diametr: CGFloat = 0
    
    let standardDuration = 0.1
    
    var buttonAdCancel = CircleButton()
    
    //in pause
    var buttonRestart = CircleButton()
    var buttonContinue = CircleButton()
    var buttonBackMenu = CircleButton()
    var buttonSettings = CircleButton()
    
    //in successful finish
    var buttonNext = CircleButton()
    var buttonBackNext = TextButton()
    var buttonRestartFinish = TextButton()
    
    //in unsuccessful finish
    var buttonBigRestart = CircleButton()
    var buttonBackRestart = TextButton()
    
    var currentGame = LevelGame()
    
    var score = ScoreView()
    var squareNext = NextRectView()
    var circleLine = CircleLineView()
    
    var round:Array <RoundView> = []
    var squareTask: Array<TaskRectView> = []
    
    var playingSize = 0
    
    var lettersOnRect: Bool = false
    var playSound: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.createSound() 
        self.calculateSquareWidth()
        self.createCircleLine()
        self.createScore()
        self.createSquareNext()
        self.createRoundButtons()
        self.createTextButton()
        
        self.startLevelGame()
        //self.currentGame.startGame()
        self.score.animateScore(pause: true, wait: 0.0, duration: 0.0)
        self.circleLine.animateCircles(pause: true, wait: 0.0, duration: 0.0)
        self.squareNext.animateNext(pause: true, wait: 0.0, duration: 0.0)
        self.animateTask(pause: true, wait: 0.0, duration: 0.0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewwillappear LevelGameViewController")
        lettersOnRect = Settings.lettersOnRect
        playSound = Settings.sound
        self.refreshScene()
        self.animateScene(pause: true, wait: 0.0, duration: 0.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewdidappear LevelGameViewController")
        self.animateTask(pause: false, wait: 0.2 + 0.25, duration: 0.1)
        self.animateScene(pause: false, wait: 0.2 + 0.45, duration: 0.1)
        self.score.animateScore(pause: false, wait: 0.2 + 0.25, duration: 0.1)
        self.circleLine.animateCircles(pause: false, wait: 0.2, duration: 0.1)
        self.squareNext.animateNext(pause: false, wait: 0.2 + 0.25, duration: 0.1)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    func loadInterstitialAd() {
        interstitialAd = ADInterstitialAd()
        interstitialAd.delegate = self
        //buttonAdCancel.hidden = false
        //interstitialAdView.hidden = false
    }
    
    func interstitialAdWillLoad(interstitialAd: ADInterstitialAd!) {
        print("interstitialAdWillLoad")
    }
    
    func interstitialAdDidLoad(interstitialAd: ADInterstitialAd!) {
        print("interstitialAdDidLoad")
        
       // buttonAdCancel.hidden = false
        interstitialAdView = UIView()
        interstitialAdView.frame = self.view.bounds
        view.addSubview(interstitialAdView)
        interstitialAdView.hidden = true
        
        
        
        buttonAdCancel = CircleButton(x: 0, y: 0, screenWidth: self.screenWidth, screenHeight: self.screenHeight, typeButton: 12)
        //buttonAdCancel.hidden = true
        buttonAdCancel.callback = {
            print("button ad cancel callback")
            self.interstitialAdView.removeFromSuperview()
            self.buttonAdCancel.removeFromSuperview()
            self.interstitialAd = nil
        }
        buttonAdCancel.inCircle.backgroundColor = UIColor.blackColor()
        buttonAdCancel.outCircle.backgroundColor = UIColor.blackColor()
        //self.view.addSubview(buttonAdCancel)
        
        
        interstitialAd.presentInView(interstitialAdView)
        UIViewController.prepareInterstitialAds()
        
        
        self.interstitialAdView.addSubview(buttonAdCancel)
    }
    
    func interstitialAdActionDidFinish(interstitialAd: ADInterstitialAd!) {
        print("interstitialAdActionDidFinish")
        //interstitialAdView.removeFromSuperview()
       // buttonAdCancel.hidden = true
        //interstitialAdView.hidden = true
    }
    
    func interstitialAdActionShouldBegin(interstitialAd: ADInterstitialAd!, willLeaveApplication willLeave: Bool) -> Bool {
        print("interstitialAdActionShouldBegin")
        return true
    }
    
    func interstitialAd(interstitialAd: ADInterstitialAd!, didFailWithError error: NSError!) {
        print("interstitialAd")
        
    }
    
    func interstitialAdDidUnload(interstitialAd: ADInterstitialAd!) {
        print("interstitialAdDidUnload")
       // buttonAdCancel.hidden = true
        //interstitialAdView.removeFromSuperview()
        interstitialAdView.hidden = true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        /*if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
        return .AllButUpsideDown
        } else {
        return .All
        }*/
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func createSound() {
        let audioPath = NSBundle.mainBundle().pathForResource("click", ofType: "wav")
        var error:NSError? = nil
        do {
            clickPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }
    }
    
    private func createCircleLine() {
        circleLine = CircleLineView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        circleLine.callback = {
            //self.pause(true)
            self.createSquares()
        }
        self.view.addSubview(circleLine)
    }
    
    private func createScore() {
        score = ScoreView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        score.callback = {
            self.pause(true)
        }
        self.view.addSubview(score)
    }
    
    private func createSquareNext() {
        squareNext = NextRectView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        squareNext.callback = {
            //self.pause(true)
        }
        self.view.addSubview(squareNext)
    }
    
    private func createRoundButtons() {
        
        buttonContinue = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62) / 2, y: (screenHeight - screenHeight / 1.62 / 1.62) / 2  , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 1)
        buttonContinue.letterLabel.text = "Continue"
        buttonContinue.inCircle.backgroundColor = UIColor.getSquareColor(5)
        buttonContinue.outCircle.backgroundColor = UIColor.getRingColor(5)
        buttonContinue.callback = {
            self.pause(false)
        }
        buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonContinue)
        
        buttonRestart = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62 / 1.62) / 2, y: 0.8 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 3)
        buttonRestart.letterLabel.text = "Restart"
        buttonRestart.inCircle.backgroundColor = UIColor.getSquareColor(6)
        buttonRestart.outCircle.backgroundColor = UIColor.getRingColor(6)
        buttonRestart.callback = {
            self.restartLevel()
            self.refreshScene()
            self.pause(false)
        }
        buttonRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonRestart)
        
        buttonBackMenu = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62 / 1.62) / 2 - 0.3 * screenWidth,
                                      y: 0.8 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 3)
        buttonBackMenu.letterLabel.text = "menu"
        buttonBackMenu.textSize = 10
        buttonBackMenu.inCircle.backgroundColor = UIColor.getSquareColor(1)
        buttonBackMenu.outCircle.backgroundColor = UIColor.getRingColor(1)
        buttonBackMenu.callback = {
            self.goBack()
        }
        buttonBackMenu.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBackMenu)
        
        buttonSettings = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62 / 1.62) / 2 + 0.3 * screenWidth,
                                      y: 0.8 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 3)
        buttonSettings.letterLabel.text = "Settings"
        buttonSettings.textSize = 10
        buttonSettings.inCircle.backgroundColor = UIColor.getSquareColor(2)
        buttonSettings.outCircle.backgroundColor = UIColor.getRingColor(2)
        buttonSettings.callback = {
            self.buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonBackMenu.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonSettings.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "presentSettings", userInfo: nil, repeats: false)
        }
        buttonSettings.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonSettings)
        
        buttonNext = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62) / 2, y: (screenHeight - screenHeight / 1.62 / 1.62) / 2 , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 1)
        buttonNext.letterLabel.text = "Next"
        buttonNext.inCircle.backgroundColor = UIColor.getSquareColor(8)
        buttonNext.outCircle.backgroundColor = UIColor.getRingColor(8)
        buttonNext.callback = {
            self.nextLevel()
            self.successfulFinish(false)
        }
        buttonNext.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonNext)
        
        buttonBigRestart = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62) / 2, y: (screenHeight - screenHeight / 1.62 / 1.62) / 2 , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 1)
        buttonBigRestart.letterLabel.text = "Restart"
        buttonBigRestart.inCircle.backgroundColor = UIColor.getSquareColor(8)
        buttonBigRestart.outCircle.backgroundColor = UIColor.getRingColor(8)
        buttonBigRestart.callback = {
            self.restartLevel()
            self.unSuccessfulFinish(false)
        }
        buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBigRestart)
        
    }
    
    private func createTextButton() {
        buttonBackNext = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, left: true)
        //buttonBackNext = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, numberButton: 3)
        buttonBackNext.label.text = "menu"
        buttonBackNext.callback = {
            self.goBack()
            //NSTimer.scheduledTimerWithTimeInterval(0.11, target: self, selector: "nextLevel", userInfo: nil, repeats: false)
            self.nextLevel()
        }
        buttonBackNext.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBackNext)
        
        buttonRestartFinish = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, left: false)
        //buttonBackNext = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, numberButton: 3)
        buttonRestartFinish.label.text = "restart"
        buttonRestartFinish.callback = {
            self.restartLevel()
            self.successfulFinish(false)
        }
        buttonRestartFinish.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonRestartFinish)
        
        buttonBackRestart = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, center: true)
        buttonBackRestart.label.text = "menu"
        buttonBackRestart.callback = {
            self.goBack()
            //NSTimer.scheduledTimerWithTimeInterval(0.11, target: self, selector: "nextLevel", userInfo: nil, repeats: false)
            self.restartLevel()
        }
        buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBackRestart)
    }
    
    private func refreshScene() {
        
        squareNext.rect.backgroundColor = UIColor.getSquareColor(self.currentGame.getNextType())
        score.scoreLabel.text = String(currentGame.getCurrentLevel())
        
        if (lettersOnRect) {
            self.squareNext.textLabel.textAlignment = NSTextAlignment.Left
            squareNext.letterLabel.text = String.getLetter(self.currentGame.getNextType())
        }
        else {
            self.squareNext.textLabel.textAlignment = NSTextAlignment.Center
            squareNext.letterLabel.text = ""
        }
        
        for i in 0..<self.playingSize  {
            for j in 0..<self.playingSize {
                round[i * self.playingSize + j].inCircle.backgroundColor = UIColor.getSquareColor(self.currentGame.getType(i,y: j))
                round[i * self.playingSize + j].outCircle.backgroundColor = UIColor.getRingColor(self.currentGame.getType(i,y: j))
                
                if (lettersOnRect) {
                    round[i * self.playingSize + j].letterLabel.text = String.getLetter(self.currentGame.getType(i,y: j))
                }
                else {
                    round[i * self.playingSize + j].letterLabel.text = ""
                }
            }
        }
        
        for numberTask in 0..<squareTask.count {
            if (lettersOnRect) {
                squareTask[numberTask].lettersOnRect = true
            }
            else {
                squareTask[numberTask].lettersOnRect = false
            }
        }
    }
    
    private func createSquares() {
        
        self.deleteSquares()
        
        for i in 0..<playingSize {
            for j in 0..<playingSize {
                let jj:CGFloat = CGFloat(j)
                let ii:CGFloat = CGFloat(i)
                let square = RoundView(diametr: diametr)
                square.inCircle.backgroundColor = UIColor.getSquareColor(2)
                square.outCircle.backgroundColor = UIColor.getRingColor(2)
                square.frame = CGRect.getPositionSquare(ii, jj: jj, blockDistance: blockDistance, diametr: diametr)
                square.callback = {
                    if (self.currentGame.empty(square.location.x, y: square.location.y)) {
                        square.transform = CGAffineTransformMakeScale(0.1, 0.1)
                        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
                            square.transform = CGAffineTransformMakeScale(1, 1)
                            }, completion: {finished in
                        })
                    }
                    self.click(Int(square.location.x), y: Int(square.location.y))
                }
                square.location = CGPoint(x: ii, y: jj)
                square.transform = CGAffineTransformMakeScale(0.000001, 0.000001) 
                round.append(square)
                self.view.addSubview(square)
            }
        }
    }
    
    private func createTask(level: Int) {
        self.deleteTasks()
        let levels = Levels()
        var dict = levels.onTypeLevels[level]
        dict.removeValueForKey("randType")
        dict.removeValueForKey("size")
        var keys = Array(dict.keys)
        let taskCount = keys.count
        for var i = 0; i < taskCount; i++ {
            let taskSquare = TaskRectView(screenWidth: self.screenWidth, screenHeight: self.screenHeight, numberTask: CGFloat(i + 1), countTask: CGFloat(taskCount))
            let key = keys[i]
            taskSquare.taskLabel.text = "x " + String(levels.onTypeLevels[level][String(key)]!)
            taskSquare.roundType = Int(key)!
            taskSquare.lettersOnRect = self.lettersOnRect
            squareTask.append(taskSquare)
            self.view?.addSubview(taskSquare)
        }
    }
    
    private func deleteTasks() {
        for numberTask in 0..<squareTask.count {
            squareTask[numberTask].removeFromSuperview()
        }
        squareTask.removeAll()
    }
    
    private func deleteSquares() {
        for numberTask in 0..<round.count {
            round[numberTask].removeFromSuperview()
        }
        round.removeAll()
    }
    
    private func pause(on: Bool) {
        if on {
            self.animateScene(pause: true, wait: 0.0, duration: 0.1)
            self.score.animateScore(pause: true, wait: 0.1, duration: 0.1)
            self.circleLine.animateCircles(pause: true, wait: 0.2, duration: 0.1)
            self.squareNext.animateNext(pause: true, wait: 0.1, duration: 0.1)
            self.animateTask(pause: true, wait: 0.1, duration: 0.1)
            
            self.buttonContinue.animateButton(onScreen: true, wait: 0.4, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: true, wait: 0.5, duration: 0.1)
            self.buttonBackMenu.animateButton(onScreen: true, wait: 0.5, duration: 0.1)
            self.buttonSettings.animateButton(onScreen: true, wait: 0.5, duration: 0.1)
        }
        else {
            self.animateScene(pause: false, wait: 0.2 + 0.45, duration: 0.1)
            self.score.animateScore(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.circleLine.animateCircles(pause: false, wait: 0.2, duration: 0.1)
            self.squareNext.animateNext(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.animateTask(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            
            self.buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonBackMenu.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonSettings.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
        }
    }
    
    private func successfulFinish(on: Bool) {
        if on {
            self.animateScene(pause: true, wait: 0.5, duration: 0.1)
            self.score.animateScore(pause: true, wait: 0.6, duration: 0.1)
            self.circleLine.animateCircles(pause: true, wait: 0.7, duration: 0.1)
            self.squareNext.animateNext(pause: true, wait: 0.6, duration: 0.1)
            self.animateTask(pause: true, wait: 0.6, duration: 0.1)
            
            self.buttonNext.animateButton(onScreen: true, wait: 0.3 + 0.5, duration: 0.1)
            self.buttonBackNext.animateButton(onScreen: true, wait: 0.3 + 0.5, duration: 0.1)
            self.buttonRestartFinish.animateButton(onScreen: true, wait: 0.3 + 0.5, duration: 0.1)
            
            self.loadInterstitialAd()
        }
        else {
            /*if (interstitialAd.loaded) {
                self.interstitialAdView.hidden = false
            }*/
            self.animateScene(pause: false, wait: 0.2 + 0.45, duration: 0.1)
            self.score.animateScore(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.circleLine.animateCircles(pause: false, wait: 0.2, duration: 0.1)
            self.squareNext.animateNext(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.animateTask(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            
            self.buttonNext.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonBackNext.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonRestartFinish.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.refreshScene()
        }
    }
    
    private func unSuccessfulFinish(on: Bool) {
        if on {
            self.animateScene(pause: true, wait: 0.5, duration: 0.1)
            self.score.animateScore(pause: true, wait: 0.6, duration: 0.1)
            self.circleLine.animateCircles(pause: true, wait: 0.7, duration: 0.1)
            self.squareNext.animateNext(pause: true, wait: 0.6, duration: 0.1)
            self.animateTask(pause: true, wait: 0.6, duration: 0.1)
            
            self.buttonBigRestart.animateButton(onScreen: true, wait: 0.8, duration: 0.1)
            self.buttonBackRestart.animateButton(onScreen: true, wait: 0.8, duration: 0.1)
            
            self.loadInterstitialAd()
        }
        else {
            /*if (interstitialAd.loaded) {
                self.interstitialAdView.hidden = false
            }*/
            self.animateScene(pause: false, wait: 0.2 + 0.45, duration: 0.1)
            self.score.animateScore(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.circleLine.animateCircles(pause: false, wait: 0.2, duration: 0.1)
            self.squareNext.animateNext(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            self.animateTask(pause: false, wait: 0.2 + 0.25, duration: 0.1)
            
            self.buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            
            self.refreshScene()
        }
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(false, completion: {
            self.animateHideScene()
            self.score.animateScore(pause: true, wait: 0, duration: 0)
        })
    }
    
    func click(x: Int, y: Int) {
        if (currentGame.getType(x, y: y) == 0) {
            currentGame.clickButton(x, y: y, type: currentGame.getNextType(), fromAnalyze: false)
            self.refreshScene()
            self.checkGameOver()
            self.checkLevelCompleted()
            if (playSound) {
                self.clickPlayer.play()
            }
        }
    }
    
    private func goBack() {
        self.buttonRestartFinish.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonBackMenu.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonBackNext.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonNext.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        
        self.buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: standardDuration)
        self.buttonRestart.animateButton(onScreen: false, wait: standardDuration + 0.1, duration: standardDuration)
        self.buttonBackMenu.animateButton(onScreen: false, wait: standardDuration + 0.1, duration: standardDuration)
        self.buttonSettings.animateButton(onScreen: false, wait: standardDuration + 0.1, duration: standardDuration)
        NSTimer.scheduledTimerWithTimeInterval(standardDuration + 0.1, target: self, selector: "dismissViewController", userInfo: nil, repeats: false)
    }
    
    private func animateHideScene() {
        for i in 0..<playingSize {
            for j in 0..<playingSize {
                self.round[i * self.playingSize + j].transform = CGAffineTransformMakeScale(0, 0)
            }
        }
    }
    
    private func animateScene(pause pause: Bool, wait: Double, duration: Double) {
        
        if pause {
            for i in 0..<playingSize {
                for j in 0..<playingSize {
                    UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                        self.round[i * self.playingSize + j].transform = CGAffineTransformMakeScale(0.000001, 0.000001)
                        }, completion: {finished in
                    })
                }
            }
        }
        else {
            for i in 0..<playingSize {
                for j in 0..<playingSize {
                    self.round[i * self.playingSize + j].transform = CGAffineTransformMakeScale(0, 0)
                    UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                        self.round[i * self.playingSize + j].transform = CGAffineTransformMakeScale(1, 1)
                        }, completion: {finished in
                    })
                }
            }
        }
    }
    
    private func animateCircleLine(pause pause: Bool, wait: Double, duration: Double) {
        if pause {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.circleLine.frame.origin.y = 1.2 * self.screenHeight
                }, completion: {finished in
            })
        }
        else {UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                self.circleLine.frame.origin.y = 0.95 * self.screenHeight
                //self.score.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: {finished in
                    ///self.score.hidden = true
            })
        }
    }
    
    private func animateTask(pause pause: Bool, wait: Double, duration: Double) {
        if pause {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                for i in 0..<self.squareTask.count {
                    self.squareTask[i].animateTask(pause: pause, wait: wait, duration: duration)
                }
                }, completion: {finished in
            })
        }
        else {
            UIView.animateWithDuration(duration, delay: wait, options: .CurveLinear, animations: {
                for i in 0..<self.squareTask.count {
                    self.squareTask[i].animateTask(pause: pause, wait: wait, duration: duration)
                }
                }, completion: {finished in
            })
        }
    }
    
    private func startLevelGame(level: Int) {
        currentGame.setLevelSettings(level: level)
        playingSize = currentGame.getPlayingSize()
        currentGame.startGame()
        self.calculateSquareWidth()
        self.createSquares()
        self.createTask(currentGame.getCurrentLevel())
        self.animateTask(pause: true, wait: 0.0, duration: 0.0)
    }
    private func startLevelGame() {
        currentGame.setLevelSettings()
        playingSize = currentGame.getPlayingSize()
        currentGame.startGame()
        self.calculateSquareWidth()
        self.createSquares()
        self.createTask(currentGame.getCurrentLevel())
        self.animateTask(pause: true, wait: 0.0, duration: 0.0)
    }
    
    func nextLevel() {
        //self.startLevelGame(currentGame.getCurrentLevel() + 1)
        //self.currentGame.saveLevel()
        self.currentGame.nextLevel()
        self.playingSize = currentGame.getPlayingSize()
        self.calculateSquareWidth()
        self.createSquares()
        self.createTask(currentGame.getCurrentLevel())
        self.animateTask(pause: true, wait: 0.0, duration: 0.0)
    }
    
    private func restartLevel() {
        currentGame.restartLevel()
        //self.refreshScene()
    }
    
    private func checkGameOver() {
        if (currentGame.getCountFilledBlock() == playingSize * playingSize && !currentGame.checkProgress()) {
            self.unSuccessfulFinish(true)
        }
    }
    
    private func checkLevelCompleted() {
        if (currentGame.checkProgress()) {
            self.successfulFinish(true)
        }
    }
    
    private func calculateSquareWidth() {
        diametr = (screenWidth - 3 * 2 * blockDistance - blockDistance * CGFloat(playingSize - 1)) / CGFloat(playingSize)
    }
    
    func presentSettings() {
        self.presentViewController(settingsView, animated: false, completion: nil)
    }
}
