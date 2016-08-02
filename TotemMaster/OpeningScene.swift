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
    
    func setController(controller : GameProtocol) {
        self.controller = controller
    }
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        controller.startGame()
    }
}