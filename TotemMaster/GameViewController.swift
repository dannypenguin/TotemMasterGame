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
   // var playerTitle: String = "Monkey's Uncle"
    var playerExp: Int = 0
    var gameDis: CGFloat = 0.0
    let highScoreKey = "highScoreKey"
    let highTitleKey = "highTitleKey"
    let longDistanceKey = "longDistanceKey"
    var careerDis: Int = 0
    var titleRankCheck:[String] = ["Monkey's Uncle", "Monkey Scrapper", "Monkey Collector", "Monkey Gatherer", "Monkey Trainer", "Monkey Mogul", "Monkey Maniac", "Monkey Master", "Monkey GrandMaster"]


    override func viewDidLoad() {
        super.viewDidLoad()
        openingScene()
    }
    
    func openingScene() {
        if let scene = OpeningScene(fileNamed: "OpeningScene") {
            massageScene(scene)
        }
    }
    
    func tutorialScene() {
        if let scene = TutorialScene(fileNamed: "TutorialScene"){
            massageScene(scene)
        } 
    }
    
    func gameLimbo() {
        if let scene = GameLimbo(fileNamed: "GameLimbo") {
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
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .Fill
        
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
        let careerScore = getCareerScore()
        setCareerScore(careerScore + temp)
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
        } else if temp >= 400 {
            temp2 = 8
        }
        
        
        return temp2
        
    }
    
    
    func gameOver() {
        if let scene = GameOverScene(fileNamed:"GameOverScene") {
            massageScene(scene)
            var monkeyTitle: SKLabelNode!
            monkeyTitle = scene.childNodeWithName("monkeyTitle") as! SKLabelNode
            let tempTitle = getPlayerTitle()
            let playerTitle = titleRankCheck[tempTitle]
            
            let oldCareerTitle = getCareerTitle()
            if oldCareerTitle < tempTitle {
                setCareerTitle(tempTitle)
            }
            monkeyTitle.text = "Rank: \(playerTitle)"
            var gameDistanceLabel: SKLabelNode!
            gameDistanceLabel = scene.childNodeWithName("gameDistance") as! SKLabelNode
            let retrieveDis = self.gameDis
            let calculateDis = Int(retrieveDis/60)
            
            let tempDistance = getCareerLongDis()
            if tempDistance < calculateDis {
                setCareerLongDis(calculateDis)
            }
            
            
            
            gameDistanceLabel.text = "Distance: \(Int(calculateDis)) Banana Feet"
            
            
            
            
            
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
    
    func getCareerScore() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey(highScoreKey)
    }
    
    func setCareerScore(inc: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(inc, forKey: highScoreKey)
    }
    
    func getCareerTitle() -> Int {
        
        let title = NSUserDefaults.standardUserDefaults().integerForKey(highTitleKey)
        return title
    }
    func setCareerTitle(inc: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(inc, forKey: highTitleKey)
    }
    
    func getCareerTitleAsString() -> String {
        let temp = getCareerTitle()
        return titleRankCheck[temp]
    }
    
    func getCareerLongDis() -> Int {
        let longDis = NSUserDefaults.standardUserDefaults().integerForKey(longDistanceKey)
            return longDis
    }
    
    func setCareerLongDis(inc: Int){
        NSUserDefaults.standardUserDefaults().setInteger(inc, forKey: longDistanceKey)
    }
    
}
