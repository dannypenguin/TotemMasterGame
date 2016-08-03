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
    
    func massageScene(scene: SKScene) {
        
        let skView = self.view as! SKView
        let ss = scene as! Scene
        ss.setController(self)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
    }
    
    func gameOver() {
        if let scene = GameOverScene(fileNamed:"GameOverScene") {
            massageScene(scene)
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func incrementScore(bonus: Int) -> Int {
        score += bonus
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
