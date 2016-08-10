//
//  OpeningScene.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/2/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class OpeningScene : SKScene, Scene {
    
    var controller : GameProtocol!
    var playButton = ButtonNode(normalImageNamed: "PlayButton-1", activeImageNamed: "PlayButton-1", disabledImageNamed: "PlayButton-1")
    
    var tutorialButton = ButtonNode(normalImageNamed: "Tutorial", activeImageNamed: "Tutorial", disabledImageNamed: "Tutorial")
    
    var highScoreButton = ButtonNode(normalImageNamed: "HighScore-1", activeImageNamed: "HighScore-1", disabledImageNamed: "HighScore-1")
    
    
    func setController(controller : GameProtocol) {
        self.controller = controller
    }
    override func didMoveToView(view: SKView) {
        addChild(playButton)
        playButton.zPosition = 1
        playButton.position.x = 460
        playButton.position.y = 130
        setScale(0.8)
        playButton.selectedHandler = {
           self.controller.startGame()
        }
        
        addChild(tutorialButton)
        tutorialButton.zPosition = 1
        tutorialButton.position.x = 460
        tutorialButton.position.y = 50
        tutorialButton.setScale(0.98)
        tutorialButton.selectedHandler = {
            print("Help")
            self.controller.tutorialScene()
        }
        
        addChild(highScoreButton)
        highScoreButton.zPosition = 1
        highScoreButton.position.x = scene!.size.width/8
        highScoreButton.position.y = scene!.size.height - scene!.size.height/10
        highScoreButton.setScale(0.8)
        highScoreButton.selectedHandler = {
            print("Help")
            self.controller.gameLimbo()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}