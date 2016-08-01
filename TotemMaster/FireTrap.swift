//
//  Trap.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/14/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit



class FireTrap : SKSpriteNode, Trap {
    
    var fire: SKEmitterNode!

    init() {
        

        let texture = SKTexture(imageNamed: "firePitRev1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //anchorPoint = CGPoint(x: 0, y: 0)
        var textures = [SKTexture]()
        for i in 1...3 {
            textures.append(SKTexture(imageNamed: "firePitRev\(i)"))
        }
        
        physicsBody = SKPhysicsBody(circleOfRadius: 50)
        physicsBody!.categoryBitMask = PhysicsCategory.Trap
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.dynamic = false
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
        
        fire = SKEmitterNode(fileNamed: "Fire")!
        addChild(fire)
        fire.zPosition = 44
        name = "trap"
    }
    
    func damage() -> Int {
        return 5
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
 