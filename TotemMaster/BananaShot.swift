//
//  BananaShot.swift
//  TotemMaster
//
//  Created by Danny Peng on 8/3/16.
//  Copyright © 2016 Danny Peng. All rights reserved.
//

import SpriteKit

class BananaShot: SKSpriteNode {
    
    var fire: SKEmitterNode!
    
    init() {
        
        let texture = SKTexture(imageNamed: "bananagun1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        var textures = [SKTexture]()
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "bananagun\(i)"))
        }
        
        let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.2)
        let animateForever = SKAction.repeatActionForever(animate)
        runAction(animateForever)
        
        fire = SKEmitterNode(fileNamed: "Fire")!
        addChild(fire)
        fire.zPosition = 44
        name = "trap"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
