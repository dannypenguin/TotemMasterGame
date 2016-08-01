//
//  ArrowTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class ArrowTrap : SKSpriteNode, Trap {
    
    var arrowWoosh: SKEmitterNode!
    
    init() {
                
        let texture = SKTexture(imageNamed: "arrowTrap")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        physicsBody = SKPhysicsBody(circleOfRadius: 50)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
        
        arrowWoosh = SKEmitterNode(fileNamed: "ArrowWoosh")!
        arrowWoosh.targetNode = parent
        addChild(arrowWoosh)
        arrowWoosh.zPosition = 44
        name = "trap"
    }
    
    func damage() -> Int {
        return 9
    }
    
    func scoreCounter() -> Int {
        return 1
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}