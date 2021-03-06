//
//  DoorTrap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/22/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class DoorTrap : Trap {
    
    init() {
        
        
        let texture = SKTexture(imageNamed: "trapDoor1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
         var textures = [SKTexture]()
         for i in 1...4 {
         textures.append(SKTexture(imageNamed: "trapDoor\(i)"))
         }
        zPosition = 1
        physicsBody = SKPhysicsBody(circleOfRadius: 20)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
         
         let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
         let animateForever = SKAction.repeatActionForever(animate)
         runAction(animateForever)
        
        name = "trap"
    }
    
    override func damage() -> Int {
        return 7
    }
    
    override func scoreCounter() -> Int {
        return 0
    }
    
    func armTrap() {
        print("The Trap is armed!")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}