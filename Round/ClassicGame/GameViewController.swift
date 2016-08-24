//
//  GameViewController.swift
//  Block 8
//
//  Created by Фёдор on 09.01.16.
//  Copyright (c) 2016 Фёдор. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox
import iAd
import GameKit

class GameViewController: UIViewController, ADInterstitialAdDelegate {
    
    var clickPlayer:AVAudioPlayer = AVAudioPlayer()
    
    let settingsView = SettingsViewController()

    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let blockDistance: CGFloat = 2
    var diametr: CGFloat = 0
    
    var interstitialAd:ADInterstitialAd!
    var interstitialAdView: UIView = UIView()
    
    var buttonAdCancel = CircleButton()
    
    var buttonRestart = CircleButton()
    var buttonContinue = CircleButton()
    var buttonBackMenu = CircleButton()
    var buttonSettings = CircleButton()
    
    //in unsuccessful finish
    var buttonBigRestart = CircleButton()
    var buttonBackRestart = TextButton()
    
    var score = ScoreView()
    var squareNext = NextRectView()
    var circleLine = CircleLineView()
    var round:Array <RoundView> = []
    
    var currentGame = GameModel()
    
    let playingSize = 5
    
    var lettersOnRect: Bool = false
    var playSound: Bool = false
    
    //var gameOver: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseOnBackground", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.createSound()
        self.calculateSquareWidth()
        self.createCircleLine()
        self.createScore()
        self.createSquareNext()
        self.createSquares()
        self.createRoundButtons()
        self.createTextButton()
        
        self.startNewGame()
        
        
        self.score.animateScore(pause: true, wait: 0.0, duration: 0.0)
        self.circleLine.animateCircles(pause: true, wait: 0.0, duration: 0.0)
        self.squareNext.animateNext(pause: true, wait: 0.0, duration: 0.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewwillappear1")
        lettersOnRect = Settings.lettersOnRect
        playSound = Settings.sound
        
        self.refreshScene()
        self.animateScene(pause: true, wait: 0.0, duration: 0.0)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animateScene(pause: false, wait: 0.2 + 0.45, duration: 0.1)
        self.score.animateScore(pause: false, wait: 0.2 + 0.25, duration: 0.1)
        self.circleLine.animateCircles(pause: false, wait: 0.2, duration: 0.1)
        self.squareNext.animateNext(pause: false, wait: 0.2 + 0.25, duration: 0.1)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func loadInterstitialAd() {
        interstitialAd = ADInterstitialAd()
        interstitialAd.delegate = self
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
        
        
        
        buttonAdCancel = CircleButton(x: 25, y: 25, screenWidth: self.screenWidth, screenHeight: self.screenHeight, typeButton: 12)
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
    
    private func createSquareNext() {
        squareNext = NextRectView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        squareNext.callback = {
            //self.pause(true)
        }
        self.view.addSubview(squareNext)
    }
    
    private func createCircleLine() {
        circleLine = CircleLineView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        circleLine.callback = {
            //self.pause(true)
        }
        self.view.addSubview(circleLine)
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(false, completion: {
            self.animateHideScene()
            self.score.animateScore(pause: true, wait: 0, duration: 0)
        })
    }
    
    private func createScore() {
        score = ScoreView(screenWidth: self.screenWidth, screenHeight: self.screenHeight)
        score.callback = {
            self.pause(true)
        }
        self.view.addSubview(score)
    }
    
    private func createRoundButtons() {
        buttonContinue = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62) / 2, y: (screenHeight - screenHeight / 1.62 / 1.62) / 2  , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 1)
        buttonContinue.letterLabel.text = "go on"
        buttonContinue.inCircle.backgroundColor = UIColor.getSquareColor(5)
        buttonContinue.outCircle.backgroundColor = UIColor.getRingColor(5)
        buttonContinue.callback = {
            self.pause(false)
        }
        buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonContinue)
        
        buttonRestart = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62 / 1.62) / 2, y: 0.8 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 3)
        buttonRestart.letterLabel.text = "RR"
        buttonRestart.inCircle.backgroundColor = UIColor.getSquareColor(6)
        buttonRestart.outCircle.backgroundColor = UIColor.getRingColor(6)
        buttonRestart.callback = {
            self.startNewGame()
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
        buttonSettings.letterLabel.text = "Sett"
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
        
        buttonBigRestart = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62) / 2, y: (screenHeight - screenHeight / 1.62 / 1.62) / 2 , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 1)
        buttonBigRestart.letterLabel.text = "RR"
        buttonBigRestart.inCircle.backgroundColor = UIColor.getSquareColor(8)
        buttonBigRestart.outCircle.backgroundColor = UIColor.getRingColor(8)
        buttonBigRestart.callback = {
            self.startNewGame()
            self.unSuccessfulFinish(false)
        }
        buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBigRestart)
    }
    
    private func createTextButton() {
        buttonBackRestart = TextButton(screenWidth: screenWidth, screenHeight: screenHeight, center: true)
        buttonBackRestart.label.text = "menu"
        buttonBackRestart.callback = {
            self.goBack()
            self.startNewGame()
        }
        buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.0)
        self.view.addSubview(buttonBackRestart)
    }
    
    private func refreshScene() {
        
        squareNext.rect.backgroundColor = UIColor.getSquareColor(self.currentGame.getNextType())
        score.scoreLabel.text = currentGame.getScore()
        
        if (lettersOnRect) {
            self.squareNext.textLabel.textAlignment = NSTextAlignment.Left
        }
        else {
            self.squareNext.textLabel.textAlignment = NSTextAlignment.Center
        }
        
        if (lettersOnRect) {
            squareNext.letterLabel.text = String.getLetter(self.currentGame.getNextType())
        }
        else {
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
    
    func createSquares() {
        
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
                round.append(square)
                
                self.view.addSubview(square)
            }
        }
    }
    
    func click(x: Int, y: Int) {
        if (currentGame.getType(x, y: y) == 0) {
            currentGame.clickButton(x, y: y, type: currentGame.getNextType(), fromAnalyze: false)
            self.refreshScene()
            self.checkGameOver()
            if (playSound) {
                self.clickPlayer.play()
            }
        }
    }
    
    private func pause(on: Bool) {
        if on {
            self.animateScene(pause: true, wait: 0.0, duration: 0.1)
            self.score.animateScore(pause: true, wait: 0.1, duration: 0.1)
            self.circleLine.animateCircles(pause: true, wait: 0.2, duration: 0.1)
            self.squareNext.animateNext(pause: true, wait: 0.1, duration: 0.1)
            
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
            
            self.buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonBackMenu.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonSettings.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
        }
    }
    
    private func unSuccessfulFinish(on: Bool) {
        if on {
            self.animateScene(pause: true, wait: 0.5, duration: 0.1)
            self.score.animateScore(pause: true, wait: 0.5, duration: 0.1)
            self.circleLine.animateCircles(pause: true, wait: 0.5, duration: 0.1)
            self.squareNext.animateNext(pause: true, wait: 0.5, duration: 0.1)
            
            self.buttonBigRestart.animateButton(onScreen: true, wait: 0.6, duration: 0.1)
            self.buttonBackRestart.animateButton(onScreen: true, wait: 0.6, duration: 0.1)
            
            self.loadInterstitialAd()
        }
        else {
            if (interstitialAd.loaded) {
                self.interstitialAdView.hidden = false
            }
            self.animateScene(pause: false, wait: 0.1 + 0.5, duration: 0.1)
            self.score.animateScore(pause: false, wait: 0.1 + 0.3, duration: 0.1)
            self.circleLine.animateCircles(pause: false, wait: 0.1, duration: 0.1)
            self.squareNext.animateNext(pause: false, wait: 0.1 + 0.3, duration: 0.1)
            
            self.buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            
            self.refreshScene()
        }
    }
    
    private func goBack() {
        self.buttonBigRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
        self.buttonBackRestart.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
        self.buttonContinue.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
        self.buttonRestart.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
        self.buttonBackMenu.animateButton(onScreen: false, wait: 0.2, duration: 0.1)
        self.buttonSettings.animateButton(onScreen: false, wait: 0.2, duration: 0.1)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "dismissViewController", userInfo: nil, repeats: false)
    }
    
    private func animateBack() {
        self.animateScene(pause: true, wait: 0.0, duration: 0.1)
        self.score.animateScore(pause: true, wait: 0.0, duration: 0.1)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "dismissViewController", userInfo: nil, repeats: false)
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
    
    private func checkGameOver() {
        if (currentGame.getCountFilledBlock() == playingSize * playingSize) {
            print("check Game Over")
            //gameOver = true
            self.unSuccessfulFinish(true)
        }
    }
    
    func submitScore() {
        let leaderboardID = "LeaderboardID"
        let sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(currentGame.getScoreInt())
        
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Score submitted")
                
            }
        })
    }
    
    func deleteGame() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("game")
        defaults.synchronize()
    }
    
    func startGame() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.objectForKey("game") == nil) {
            //existSaveGame = false
            currentGame.startGame()
        }
        if (defaults.objectForKey("game") != nil) {
            //existSaveGame = true
            let encodedObject = defaults.objectForKey("game") as! NSData
            currentGame = NSKeyedUnarchiver.unarchiveObjectWithData(encodedObject) as! GameModel
            
        }
    }
    
    func startNewGame() {
        currentGame.startGame()
        //self.refreshSquares()
    }
    
    private func calculateSquareWidth() {
        diametr = (screenWidth - 3 * 2 * blockDistance - blockDistance * CGFloat(playingSize - 1)) / CGFloat(playingSize)
    }
    
    func presentSettings() {
        self.presentViewController(settingsView, animated: false, completion: nil)
    }
}
