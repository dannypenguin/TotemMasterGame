//
//  GameOverScene.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/2/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene, Scene {
    
    var controller : GameProtocol!
    var restartButton = ButtonNode(normalImageNamed: "Restart-1", activeImageNamed: "Restart-1", disabledImageNamed: "Restart-1")

    
    
    func setController(controller: GameProtocol) {
        self.controller = controller
    }
    
    override func didMoveToView(view: SKView) {
        addChild(restartButton)
        restartButton.zPosition = 5
        restartButton.position.x = 250
        
        restartButton.position.y = 40
        restartButton.setScale(0.8)

        restartButton.selectedHandler = {
           
            self.controller.startGame()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    
}