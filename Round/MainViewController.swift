//
//  MainViewController.swift
//  Block 8
//
//  Created by Фёдор on 14.01.16.
//  Copyright © 2016 Фёдор. All rights reserved.
//

import Foundation
import UIKit
import iAd
import GameKit

class MainViewController: UIViewController, GKGameCenterControllerDelegate {
    
    var buttonNewGame = UIButton() as UIButton
    var buttonNewGameLevel = UIButton() as UIButton
    var buttonResults = UIButton() as UIButton
    var bannerView: ADBannerView!
    
    var buttonLevel = CircleButton()
    var buttonGame = CircleButton()
    var buttonRestart = CircleButton()
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    let newGameView = GameViewController()
    let newGameLevelView = LevelGameViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.firstRun()
        self.createButton()
        self.authenticateLocalPlayer()
    }
    
    var gcEnabled = Bool()
    var gcDefaultLeaderBoard = String()
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.presentViewController(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.authenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifer: String?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
                
                
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated, disabling game center")
                print(error)
            }
            
        }
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        self.buttonLevel.animateButton(onScreen: true, wait: 0.4, duration: 0.1)
        self.buttonGame.animateButton(onScreen: true, wait: 0.5, duration: 0.1)
        self.buttonRestart.animateButton(onScreen: true, wait: 0.6, duration: 0.1)
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func showLeaderboard() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = "LeaderboardID"
        self.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.buttonLevel.animateButton(onScreen: true, wait: 0.0, duration: 0.1)
        self.buttonGame.animateButton(onScreen: true, wait: 0.1, duration: 0.1)
        self.buttonRestart.animateButton(onScreen: true, wait: 0.2, duration: 0.1)
        print("viewWillAppear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func firstRun() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if (!defaults.boolForKey("firstRun")) {
            _ = Settings()
        }
    }
    
    func createButton() {
        
        buttonLevel = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62) / 2, y: 0.25 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 2)
        buttonLevel.letterLabel.text = "Level"
        buttonLevel.inCircle.backgroundColor = UIColor.getSquareColor(5)
        buttonLevel.outCircle.backgroundColor = UIColor.getRingColor(5)
        buttonLevel.callback = {
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "presentLevelGame", userInfo: nil, repeats: false)
            self.buttonLevel.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonGame.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: false, wait: 0.2, duration: 0.1)
        }
        self.view.addSubview(buttonLevel)
        
        buttonGame = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62) / 2, y: 0.5 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 2)
        buttonGame.letterLabel.text = "Game"
        buttonGame.inCircle.backgroundColor = UIColor.getSquareColor(6)
        buttonGame.outCircle.backgroundColor = UIColor.getRingColor(6)
        buttonGame.callback = {
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "presentGame", userInfo: nil, repeats: false)
            self.buttonLevel.animateButton(onScreen: false, wait: 0.0, duration: 0.1)
            self.buttonGame.animateButton(onScreen: false, wait: 0.1, duration: 0.1)
            self.buttonRestart.animateButton(onScreen: false, wait: 0.2, duration: 0.1)
        }
        self.view.addSubview(buttonGame)
        
        buttonRestart = CircleButton(x: (screenWidth  - screenHeight / 1.62 / 1.62 / 1.62 / 1.62) / 2, y: 0.8 * screenHeight , screenWidth: screenWidth, screenHeight: screenHeight, typeButton: 3)
        buttonRestart.letterLabel.text = "GC"
        buttonRestart.inCircle.backgroundColor = UIColor.getSquareColor(2)
        buttonRestart.outCircle.backgroundColor = UIColor.getRingColor(2)
        buttonRestart.callback = {
            self.showLeaderboard()
        }
        self.view.addSubview(buttonRestart)
    }
    
    func presentLevelGame() {
        self.presentViewController(self.newGameLevelView, animated: false, completion: nil)
        //
    }
    
    func presentGame() {
        self.presentViewController(self.newGameView, animated: false, completion: nil)
    }
    
    func buttonResults(sender:UIButton!)
    {
        let settingsView = SettingsViewController()
        self.presentViewController(settingsView, animated: false, completion: nil)
        //создание нового viewcontroller
        
    }
}