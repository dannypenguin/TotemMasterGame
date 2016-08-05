//
//  Player.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class Player : SKSpriteNode {
    
    
    static let maxHealth = 25
    var health = maxHealth
    
    init() {
        let texture = SKTexture(imageNamed: "monkey1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        var textures = [SKTexture]()
        for i in 1...5 {
            textures.append(SKTexture(imageNamed: "monkey\(i)"))
        }
        
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody!.categoryBitMask = PhysicsCategory.Player
        physicsBody!.contactTestBitMask = PhysicsCategory.Trap | PhysicsCategory.Totem
        physicsBody!.collisionBitMask = PhysicsCategory.none
        physicsBody!.affectedByGravity = false
        physicsBody!.allowsRotation = false
        zPosition = 6
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
        name = "player"

    }
    
    func takeDamage(damage: Int) -> CGFloat {
        health -= damage
        return CGFloat(health)/CGFloat(Player.maxHealth)
        
    }
    
    func isDead() -> Bool {
        return health <= 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}