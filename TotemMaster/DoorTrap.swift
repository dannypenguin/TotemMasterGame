//
//  DoorTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/22/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class DoorTrap : SKSpriteNode, Trap {
    
    init() {
        
        
        let texture = SKTexture(imageNamed: "trapDoor1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
         //anchorPoint = CGPoint(x: 0, y: 0)
         var textures = [SKTexture]()
         for i in 1...4 {
         textures.append(SKTexture(imageNamed: "trapDoor\(i)"))
         }
        
        physicsBody = SKPhysicsBody(circleOfRadius: 50)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
         
         let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
         let animateForever = SKAction.repeatActionForever(animate)
         runAction(animateForever)
        
        name = "trap"
    }
    
    func damage() -> Int {
        return 7
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