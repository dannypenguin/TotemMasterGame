//
//  YellowBanana.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/1/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class YellowBanana : Trap {
    
    init() {
        let texture = SKTexture(imageNamed: "banana")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        name = "trap"
        
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
    }
    
    override func damage() -> Int {
        return 0
    }
    
    override func scoreCounter() -> Int {
        return 1
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
