//
//  Coin.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/28/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class Coin : SKSpriteNode, Trap {
    
    let damage = 0.1
    
    init() {
       
        var score = 0
        let texture = SKTexture(imageNamed: "coin")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //anchorPoint = CGPoint(x: 0, y: 0)
        name = "trap"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 50)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
