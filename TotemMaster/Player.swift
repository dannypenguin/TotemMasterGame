//
//  Player.swift
//  TotemMaster
//
//  Created by Danny Peng on 7/20/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//


import SpriteKit

class Player : SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "monkey1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        var textures = [SKTexture]()
        for i in 1...5 {
            textures.append(SKTexture(imageNamed: "monkey\(i)"))
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}