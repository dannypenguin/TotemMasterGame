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
    
    func setController(controller : GameProtocol) {
        self.controller = controller
    }
    override func didMoveToView(view: SKView) {
        addChild(playButton)
        playButton.zPosition = 1
        playButton.position.x = 420
        playButton.position.y = 130
        playButton.selectedHandler = {
            //TODO: Move to the gameScene
           self.controller.startGame()
        }
        
        addChild(tutorialButton)
        tutorialButton.zPosition = 1
        tutorialButton.position.x = 420
        tutorialButton.position.y = 50
        tutorialButton.selectedHandler = {
            print("Help")
            //TODO: Move to the gameScene
            self.controller.tutorialScene()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}