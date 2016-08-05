//
//  GameViewController.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/12/16.
//  Copyright (c) 2016 Danny Peng. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameProtocol {
    
    var score: Int = 0
    var playerTitle: String = "Monkey's Uncle"
    var playerExp: Int = 0
    var gameDis: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        openingScene()
        
    }
    
    func openingScene() {
        if let scene = OpeningScene(fileNamed: "OpeningScene") {
            massageScene(scene)
        }
    }
    
    func startGame() {
        if let scene = GameSceneCamera(fileNamed:"GameSceneCamera") {
            self.score = 0
            massageScene(scene)
            
        }
    }
    
    func setGameDistance(dis: CGFloat) {
        self.gameDis = dis
    }
    
    func massageScene(scene: SKScene) {
        
        let skView = self.view as! SKView
        let ss = scene as! Scene
        ss.setController(self)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
    }
    func setPlayerEXP(exp: Int){
        let boostExp = getScore()
        if boostExp > 20 {
            self.playerExp = boostExp * 2
        }
    }
    
    func getPlayerTitle() -> Int {
        let temp = getScore()
        var temp2 = 0
        if temp < 20 {
            temp2 = 0
        } else if temp >= 20 && temp < 30 {
            temp2 = 1
        } else if temp >= 30 && temp < 40 {
            temp2 = 2
        } else if temp >= 40 && temp < 50 {
            temp2 = 3
        } else if temp >= 50 && temp < 60 {
            temp2 = 4
        } else if temp >= 70 && temp < 80 {
            temp2 = 5
        } else if temp >= 90 && temp < 100 {
            temp2 = 6
        } else if temp >= 100 && temp < 400 {
            temp2 = 7
        } else if temp >= 400 && temp < 800 {
            temp2 = 8
        }
        
        
        return temp2
        
    }
    
    func setPlayerTitle() {
        let rankScore = getPlayerTitle()
        switch rankScore {
        case 0:
            self.playerTitle = "Monkey's Uncle"
        case 1:
            self.playerTitle = "Monkey Scrapper"
        case 2:
            self.playerTitle = "Monkey Collector"
        case 3:
            self.playerTitle = "Monkey Gatherer"
        case 4:
            self.playerTitle = "Monkey Trainer"
        case 5:
            self.playerTitle = "Monkey Mogul"
        case 6:
            self.playerTitle = "Monkey Maniac"
        case 7:
            self.playerTitle = "Monkey Master"
        case 8:
            self.playerTitle = "Monkey GrandMaster"
        default:
            self.playerTitle = "Error Loading Monkey Title"
        }
    }
    
    func gameOver() {
        if let scene = GameOverScene(fileNamed:"GameOverScene") {
            massageScene(scene)
            var monkeyTitle: SKLabelNode!
            monkeyTitle = scene.childNodeWithName("monkeyTitle") as! SKLabelNode
            setPlayerTitle()
            monkeyTitle.text = playerTitle
            var gameDistanceLabel: SKLabelNode!
            gameDistanceLabel = scene.childNodeWithName("gameDistance") as! SKLabelNode
            var retrieveDis = self.gameDis
            var calculateDis = retrieveDis/60
            gameDistanceLabel.text = "Distance: \(Int(calculateDis)) Banana Feet "
            
            
            
            
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    
    func incrementScore(bonus: Int) -> Int {
        score += bonus
        return score
    }
    
    func setScoreGame(dec: Int) -> Int {
        score -= dec
        return score
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
